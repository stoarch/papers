unit list_userInfo;

interface
  uses
    //--[ common ]--
    adodb, classes, sysUtils,
    //--[ interfaces ]--
    interface_userInfo,
    interface_userInfoList
    ;

  type
    TUserInfoList = class( TInterfaceList, IUserInfoList )
     public
      function get_user_info( index : integer ) : IUserInfo;
      procedure set_user_info( index : integer; value : IUserInfo );

      property UserInfo[ index : integer ] : IUserInfo read get_user_info write set_user_info;
    end;//class

implementation

{ TUserInfoList }

function TUserInfoList.get_user_info(index: integer): IUserInfo;
begin
  result := inherited Items[ index ] as IUserInfo;
end;

procedure TUserInfoList.set_user_info(index: integer; value: IUserInfo);
begin
  inherited Items[ index ] := value;
end;

end.
 