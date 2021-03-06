unit loader_userData;

interface
  uses
    //--[ common ]--
    sysutils, myAccess,
    //--[ constants ]--
    const_documentDirection,
    const_documentKindInfo,
    const_string,
    const_user,
    const_userDataLoader,
    const_userInfo,
    //--[ interface ]--
    interface_documentDirection,
    interface_documentKindInfo,
    interface_userData,
    interface_userDataLoader,
    interface_userInfo,
    //--[ factories ]--
    factory_documents,
    factory_users,
    //--[ loaders ]--
    loader_userInfo,
    //--[ pools ]--
    pool_query,
    //--[ tools ]--
    tool_Environment,
    //--[ types ]--
    type_userInfo
    ;


type
  TUserDataLoader = class( TUserInfoLoader, IUserDataLoader )
    protected

      function make_user_info() : IUserInfo;override;
      function FillUserData_fromQuery( query : TMyQuery ): IUserInfo;override;
    public

      //--[ methods ]--
      function execute( nick, password : string ) : IUserData;overload;
  end;//class

implementation

uses Paperwork_ClassFactory;

{ TUserDataLoader }


function TUserDataLoader.execute(nick, password: string): IUserData;
  var
    query : TMyQuery;
begin
  result := nil;

  query := QueryPool.capture_query();
  try
    result := FusersCache.get( nick ) as IUserData;

    if( result = nil )then
    begin
        //find user by nick name
      query.SQL.Clear();
      query.SQL.Add( 'select * from paperwork.users where ' +
                     'nick = "' + nick + '" '
                   );
      query.Open();

      result := FillUserData_fromQuery( query ) as IUserData;

      FusersCache.put( nick, result );
    end;//if
  finally
    QueryPool.release_query( query );
  end;//try-finally
end;

function TUserDataLoader.FillUserData_fromQuery( query : TMyQuery ): IUserInfo;
  var
    user_data : IUserData;
    to_user   : IUserInfo;
    direction : IDocumentDirection;
    i         : integer;
    kind      : IDocumentKindInfo;
    work_query : TMyQuery;
begin
  user_data := inherited FillUserData_fromQuery( query ) as IUserData;

    //initialize
  //user_data := Fdata as IUserData; //@not clear, that fdata is owned by both

    //fill the user data from tables
  user_data.nick       := query.fieldByName( 'nick' ).asString;
  user_data.password   := query.fieldByName( 'password' ).asString;


  work_query := QueryPool.capture_query();
  try
      //and find any destinations, available for current user
      work_query.SQL.Clear();
      work_query.SQL.Add(
            'select                                                          '+
            '   paperwork.document_pipes.key_ind as direction_index,         '+
            '   paperwork.document_pipes.from_user,                          '+
            '   paperwork.document_pipes.to_user,                            '+
            '   paperwork.users.fio as to_user_fio,                          '+
            '   paperwork.roles.key_ind as to_user_role                     '+
            'from paperwork.document_pipes, paperwork.users, paperwork.roles '+
            'where                                                           '+
            '  ( paperwork.document_pipes.from_user = '+ IntToStr( user_data.user_index ) + ' ) '+
            '  and                                                           '+
            '  ( paperwork.document_pipes.to_user = paperwork.users.key_ind )'+
            '  and                                                           '+
            '  ( paperwork.users.role_ind = paperwork.roles.key_ind )        '+
            'order by paperwork.document_pipes.key_ind'
                    );

      work_query.Open();

      while( not work_query.Eof )do
      begin
        to_user := users_factory.createInstance( CLSID_USERINFO, IID_IUserInfo ) as IUserInfo;

        to_user.user_index := work_query.FieldByName( 'to_user' ).asInteger;
        to_user.fio        := work_query.FieldByName( 'to_user_fio' ).asString;
        to_user.role       := TUserRole( work_query.FieldByName( 'to_user_role' ).asInteger );

        direction := documents_factory.createInstance( CLSID_DOCUMENT_DIRECTION, IID_IDocumentDirection ) as IDocumentDirection;
        direction.from_user  := user_data;
        direction.to_user    := to_user;
        direction.direction_index := work_query.FieldByName( 'direction_index' ).asInteger;

        user_data.destination_list.add( direction );

        //to_user := nil;
        //direction := nil;

        work_query.next();
      end;//while

      work_query.Close();

      //... and for each direction find the documents, which can be sent
      for i := 0 to user_data.destination_list.count - 1 do
      begin
        direction := user_data.destination_list[ i ];

        work_query.SQL.Clear();
        work_query.SQL.Add(
            'select                                                            '+
            '  paperwork.document_sub_kinds.key_ind as kind_index,             '+
            '  paperwork.document_sub_kinds.caption                            '+
            'from                                                              '+
            '   paperwork.document_sub_kinds,                                  '+
            '   paperwork.document_pipe_avail_kinds                            '+
            'where                                                             '+
            '    paperwork.document_pipe_avail_kinds.document_sub_kind_ind =   '+
            '        paperwork.document_sub_kinds.key_ind                      '+
            ' and                                                              '+
            '    paperwork.document_pipe_avail_kinds.document_pipe_ind = ' +
              IntToStr( direction.direction_index )
          );
        work_query.open();

        while not work_query.eof do
        begin
          kind := documents_factory.createInstance( CLSID_DOCUMENT_KIND_INFO, IID_IDocumentKindInfo ) as IDocumentKindInfo;

          kind.caption := work_query.FieldByName( 'caption' ).asString;
          kind.kind_index := work_query.FieldByName( 'kind_index' ).asInteger;

          direction.document_kind_list.Add( kind );

          //kind := nil;

          work_query.next();
        end;//while

        work_query.close();
      end;//for
  finally
    QueryPool.release_query( work_query );
  end;//try-finally

    //return
  result := user_data as IUserInfo;

  //cleanup
    user_data := nil;
    to_user   := nil;
    direction := nil;
    kind      := nil;
end;



function TUserDataLoader.make_user_info: IUserInfo;
begin
  result := users_factory.createInstance( CLSID_UserData, IID_IUserData ) as IUserData;
end;

end.
