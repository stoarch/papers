unit interface_sql_documentMessageSender;

interface
  uses
      //--[ common ]--
      classes, adodb,
      //--[ interfaces ]--
      interface_documentMessageSender
      ;

  const
    IID_Isql_DocumentMessageSender : TGUID = '{DE6F944C-B260-4386-A8F0-A9CD2165F9D8}';

  type
    Isql_DocumentMessageSender = interface( IDocumentMessageSender )
                                   ['{DE6F944C-B260-4386-A8F0-A9CD2165F9D8}']
    end;//interface
implementation

end.
 