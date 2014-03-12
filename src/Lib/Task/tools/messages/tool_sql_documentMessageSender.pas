unit tool_sql_documentMessageSender;

interface
  uses
      //--[ common ]--
      sysUtils, myAccess,
      //--[ constants ]--
      const_sql_documentMessageSender,
      const_string,
      //--[ interface ]--
      interface_sql_documentMessageSender,
      //--[ pools ]--
      pool_query,
      //--[ tools ]--
      tool_documentMessageSender,
      tool_Environment,
      //--[ types ]--
      type_message
      ;

  type
    Tsql_documentMessageSender = class(
                                        TDocumentMessageSender,
                                        Isql_DocumentMessageSender
                                      )
      procedure send( sourceId, destId : integer; docId : integer; message : string );override;
    end;//class

implementation

{ TADO_documentMessageSender }


procedure tsql_documentMessageSender.send(sourceId, destId, docId: integer;
  message: string);

  var
    message_ind : integer;
    work_query  : TMyQuery;
begin
  inherited;

  work_query := QueryPool.capture_query();
  try
    //insert message
    work_query.sql.clear();
    work_query.sql.add(
       'INSERT into messages (from_user, to_user, message, status, kind ) values ' +
       '(' + intToStr( sourceId ) + ','
           + intToStr( destId )   + ','
           + '"' + message + '",'
           + '0,'  //0 = MSG_STATE_UNREAD
           + '1'   //1 = MSG_KIND_DOCUMENT
           +
       ')'
    );
    work_query.Execute();

    //find new message index
    work_query.sql.clear();
    work_query.sql.add(
        'select max(key_ind) as msg_ind from messages'
    );
    work_query.open();

    message_ind := work_query.fieldByName( 'msg_ind' ).asInteger;

    //insert document specification
    work_query.sql.clear();
    work_query.sql.add(
       'INSERT into doc_message (message_ind, doc_ind) values ('+
       intToStr( message_ind ) + ',' +
       intToStr( docId ) +
       ')'
    );
    work_query.Execute();
  finally
    QueryPool.release_query( work_query );
  end;//try-finally
end;


end.
