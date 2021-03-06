unit factory_documents;

interface
  uses
    //--[ common ]--
    activex, classes, sysUtils
    ;

  type
    documents_factory = class
    public
      class function createInstance( clsid : TGUID; iid : TGUID ) : IInterface;
    end;//class factory

implementation

  uses
    //--[ common ]--
     const_document,
     const_documentAttachment,
     const_documentAttachmentList,
     const_documentAttachmentListLoader,
     const_documentAttachmentStorage,
     const_documentDirection,
     const_documentDirectionsList,
     const_documentKindInfo,
     const_documentKindList,
     const_documentList,
     const_documentListLoader,
     const_documentStorage,
     const_folder,
     const_folderList,
     const_sql_documentMessageReceiver,
     const_sql_documentMessageSender,
    //--[ data ]--
     data_folder,
     data_document,
     data_documentAttachment,
     data_documentDirection,
     data_documentKindInfo,
    //--[ lists ]--
     list_documents,
     list_documentAttachments,
     list_documentDirections,
     list_folders,
     list_documentKinds,
    //--[ loaders ]--
     loader_documentAttachmentList,
     loader_documentsList,
    //--[ storage ]--
     storage_document,
     storage_documentAttachment,
    //--[ tools ]
     tool_sql_documentMessageReceiver,
     tool_sql_documentMessageReceiver_ArrivalChecker,
     tool_sql_documentMessageSender
    ;

{ documents_factory }

class function documents_factory.createInstance(clsid: TGUID; iid : TGUID ): IInterface;
  var
    obj : TInterfacedObject;
    intf : IInterface;
    hr  : HRESULT;
begin
  obj := nil;
  result := nil;

  //*make an object
  if( IsEqualGUID( clsid, CLSID_FolderList ))then
    obj := TFolderList.create()
  else if( IsEqualGUID( clsid, CLSID_Folder ))then
    obj := TFolder.create()
  else if( IsEqualGUID( clsid, CLSID_DocumentList ))then
    obj := TDocumentList.create()
  else if ( IsEqualGUID( clsid, CLSID_DOCUMENT ) ) then
    obj := TDocument.Create()
  else if ( IsEqualGUID( clsid, CLSID_DOCUMENT_ATTACHMENT ) ) then
    obj := TDocumentAttachment.Create()
  else if ( IsEqualGUID( clsid, CLSID_DOCUMENT_ATTACHMENT_LIST ) ) then
    obj := TDocumentAttachmentList.Create()
  else if ( IsEqualGUID( clsid, CLSID_DOCUMENT_DIRECTION ) ) then
    obj := TDocumentDirection.create()
  else if ( IsEqualGUID( clsid, CLSID_DOCUMENT_DIRECTION_LIST ) ) then
    obj := TDocumentDirectionsList.create()
  else if ( IsEqualGUID( clsid, CLSID_DOCUMENT_KIND_INFO ) ) then
    obj := TDocumentKindInfo.create()
  else if ( IsEqualGUID( clsid, CLSID_DOCUMENT_KIND_LIST ) ) then
    obj := TDocumentKindsList.create()
  else if ( IsEqualGUID( clsid, CLSID_sql_DocumentMessageSender )) then
    obj := Tsql_DocumentMessageSender.create()
  else if ( IsEqualGUID( clsid, CLSID_sql_DocumentMessageReceiver ))then
    obj := Tsql_DocumentMessageReceiver_ArrivalChecker.create()
  else if ( IsEqualGUID( clsid, CLSID_DocumentList_Loader))then
    obj := TSQL_DocumentListLoader.create()
  else if ( IsEqualGUID( clsid, CLSID_DocumentAttachmentListLoader))then
    obj := TSQL_DocumentAttachmentList_Loader.create()
  else if ( IsEqualGUID( clsid, CLSID_DocumentStorage ))then
    obj := TSQL_DocumentStorage.create()
  else if ( IsEqualGUID( clsid, CLSID_DocumentAttachmentStorage ))then
    obj := TSQL_DocumentAttachmentStorage.create()
  else
    //nothing
  ;//end if

  if( obj = nil )then
  begin
    raise Exception.create( 'documents_factory.createInstance>>������ ������ ���� �� ��������������!' );
  end;//if

 intf := obj as IInterface;

 hr := intf.queryInterface( iid, result );

 intf := nil;

 if( failed( hr ))then
  begin
    raise Exception.create( 'documents_factory.createInstance>>��������� �� ��������������!' );
  end;//if
end;

end.
 