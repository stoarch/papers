unit loader_documentAttachmentList;

interface
  uses
    //--[ class factories ]--
    paperwork_classFactory,
    //--[ common ]--
    classes, sysutils, myAccess,
    //--[ constants ]--
    const_documentAttachment,
    const_string,
    //--[ interfaces ]--
    interface_document,
    interface_documentAttachment,
    interface_documentAttachmentList_Loader,
    //--[ factories ]--
    factory_documents,
    //--[ pools ]--
    pool_query,
    //--[ tools ]--
    tool_Environment
    ;

  type
    TSQL_DocumentAttachmentList_Loader = class( TInterfacedObject, IDocumentAttachmentList_Loader )
      public
        function load( document : IDocument ) : boolean;
    end;//class

implementation

{ TSQL_DocumentAttachmentList_Loader }

function TSQL_DocumentAttachmentList_Loader.load(
           document: IDocument
         )
          : boolean;
  var
    attachment : IDocumentAttachment;
    work_query : TMyQuery;
begin
    work_query := QueryPool.capture_query();

    try
      document.attachment_list.Clear();

      work_query.SQL.clear();
      work_query.SQL.add(
       'select * from paperwork.attachments where doc_ind = ' +
       IntToStr( document.doc_ind )
      );
      work_query.open();

      while( not work_query.Eof )do
      begin
        attachment := documents_factory.createInstance( CLSID_DOCUMENT_ATTACHMENT, IID_IDocumentAttachment ) as IDocumentAttachment;

        attachment.doc_ind  := document.doc_ind;
        attachment.doc_file := work_query.fieldByName( 'doc_file' ).asString;
        attachment.caption := work_query.fieldByName( 'caption' ).asString;
        attachment.urn     := work_query.fieldByName( 'urn' ).asString;

        document.attachment_list.add( attachment );

        work_query.next();
      end;//while

     result := true;
    finally
      QueryPool.release_query( work_query );
    end;//try-finally
end;

end.
