unit data_document;

interface
  uses //--[ common ]--
        classes, sysUtils,
       //--[ constants ]--
       const_document,
       const_documentAttachmentList,
       const_userInfo,
       //--[ interfaces ]--
       interface_document,
       interface_documentAttachmentList,
       interface_integerList,
       interface_userInfo,
       //--[ factories ]--
       factory_documents,
       factory_users,
       //--[ types ]--
       type_documentInfo
       ;


type
  TDocument = class( TInterfacedObject, IDocument )
  private
    Fto_user          : IUserInfo;
    Ffrom_user        : IUserInfo;
    Fmake_date        : tdateTime;
    Fkind             : TDocumentKind;
    Fcaption          : string;
    Fattachment       : integer;
    Fcontent          : string;
    Fattachment_list  : IDocumentAttachmentList;
    Fdocument_kind    : TDocumentSubKind;
    Fflag             : TDocumentFlag;
    Fpipe_ind         : integer;
    Fdoc_ind          : integer;
    FdocState         : TDocumentState;
    Fowner_id         : integer;
    FisReaden         : boolean;
    FanswerDate       : TDateTime;
    FsendDate         : TDateTime;

  public
    constructor Create();virtual;
    destructor Destroy();override;

    //--[ accessors ]--
      function get_answer_date() : TDateTime;
      function get_attachment() : integer;
      function get_attachment_list() : IDocumentAttachmentList;
      function get_caption() : string;
      function get_content() : string;
      function get_dir_ind() : integer;
      function get_doc_ind() : integer;
      function get_doc_state() : TDocumentState;
      function get_document_kind() : TDocumentSubKind;
      function get_is_readen() : boolean;
      function get_flag() : TDocumentFlag;
      function get_from_user() : IUserInfo;
      function get_to_user() : IUserInfo;
      function get_kind() : TDocumentKind;
      function get_make_date()    : TDateTime;
      function get_pipe_ind() : integer;
      function get_owner_id() : integer;
      function get_send_date() : TDateTime;

    //--[ mutators ]--
      procedure set_answer_date( value : TDateTime );
      procedure set_attachment( value : integer );
      procedure set_attachment_list( value : IDocumentAttachmentList );
      procedure set_caption( value : string );
      procedure set_content( value : string );
      procedure set_doc_ind( value : integer );
      procedure set_doc_state( value : TDocumentState );
      procedure set_document_kind( value : TDocumentSubKind );
      procedure set_from_user( value : IUserInfo );
      procedure set_to_user( value : IUserInfo );
      procedure set_is_readen( value : boolean );
      procedure set_flag( value : TDocumentFlag );
      procedure set_kind( value : TDocumentKind );
      procedure set_make_date( value : TDateTime );
      procedure set_pipe_ind( value : integer );
      procedure set_owner_id( value : integer );
      procedure set_send_date( value : TDateTime );

    //--[ properties ]--
    property document_kind: TDocumentSubKind read get_document_kind write set_document_kind;
    property content      : string read get_content write set_content;

    property attachment   : integer read get_attachment write set_attachment;
    property attachment_list : IDocumentAttachmentList read get_attachment_list write set_attachment_list;

    property caption      : string read get_caption write set_caption;
    property make_date    : tdateTime read get_make_date write set_make_date;
    property kind         : TDocumentKind read get_kind write set_kind;

    property from_user      : IUserInfo read get_from_user write set_from_user;
    property to_user        : IUserInfo read get_to_user write set_to_user;

    property flag : TDocumentFlag read get_flag write set_flag; //document information: controlled ... e.t.c

    property doc_ind : integer read get_doc_ind write set_doc_ind;

    property state   : TDocumentState read get_doc_state write set_doc_state;

    property owner_id : integer read get_owner_id write set_owner_id;

    property isReaden : boolean read get_is_readen write set_is_readen;

    property pipe_ind : integer read get_pipe_ind write set_pipe_ind;
    property dir_ind : integer read get_dir_ind;

    property answer_date : TDateTime read get_answer_date write set_answer_date;
    property send_date : TDateTime read get_send_date write set_send_date;
    //--[ methods ]--
    procedure assign_from( source : IDocument );
  end;//class

implementation

uses Paperwork_ClassFactory;

{ TDocument }


procedure TDocument.assign_from(source: IDocument);
begin
  from_user               := source.from_user;

  make_date               := source.make_date;
  kind                    := source.kind;
  caption                 := source.Caption;

  document_kind           := source.document_kind;
  content                 := source.content;

  attachment              := source.attachment;
  attachment_list.assign_from( source.attachment_list );

  flag                    := source.flag;
  Fpipe_ind               := source.pipe_ind;
end;

constructor TDocument.Create;
begin
  inherited;

  Fattachment_list := documents_factory.createInstance( CLSID_DOCUMENT_ATTACHMENT_LIST, IID_IDocumentAttachmentList ) as IDocumentAttachmentList;
  Fto_user         := users_factory.createInstance( CLSID_UserInfo, IID_IUserInfo ) as IUserInfo;
  Ffrom_user       := users_factory.createInstance( CLSID_UserInfo, IID_IUserInfo ) as IUserInfo;
end;



destructor TDocument.Destroy;
begin
  Fto_user         := nil;
  Ffrom_user       := nil;          
  Fattachment_list := nil;

  inherited;
end;



function TDocument.get_answer_date: TDateTime;
begin
  result := FanswerDate; 
end;

function TDocument.get_attachment: integer;
begin
  result := Fattachment;
end;

function TDocument.get_attachment_list: IDocumentAttachmentList;
begin
  result := Fattachment_list;
end;

function TDocument.get_caption: string;
begin
  result := Fcaption;
end;

function TDocument.get_content: string;
begin
  result := Fcontent;
end;

function TDocument.get_dir_ind: integer;
begin
  result := get_pipe_ind() - 1;
end;

function TDocument.get_document_kind: TDocumentSubKind;
begin
  result := Fdocument_kind;
end;

function TDocument.get_doc_ind: integer;
begin
  result := Fdoc_ind;
end;

function TDocument.get_doc_state: TDocumentState;
begin
  result := FdocState;
end;

function TDocument.get_flag: TDocumentFlag;
begin
  result := Fflag;
end;

function TDocument.get_from_user: IUserInfo;
begin
  result := Ffrom_user;
end;

function TDocument.get_is_readen: boolean;
begin
  result := FisReaden;
end;

function TDocument.get_kind: TDocumentKind;
begin
  result := Fkind;
end;

function TDocument.get_make_date: TDateTime;
begin
  result := Fmake_date;
end;

function TDocument.get_owner_id: integer;
begin
  result := Fowner_id;
end;

function TDocument.get_pipe_ind: integer;
begin
  result := Fpipe_ind;
end;


function TDocument.get_send_date: TDateTime;
begin
  result := FsendDate;
end;

function TDocument.get_to_user: IUserInfo;
begin
  result := Fto_user;
end;


procedure TDocument.set_answer_date(value: TDateTime);
begin
  FanswerDate := value;
end;

procedure TDocument.set_attachment( Value: integer );
begin
  Fattachment := Value;
end;

procedure TDocument.set_attachment_list(
  Value: IDocumentAttachmentList);
begin
  Fattachment_list := Value;
end;

procedure TDocument.set_caption( Value: string );
begin
  Fcaption := Value;
end;

procedure TDocument.set_content( Value: string );
begin
  Fcontent := Value;
end;

procedure TDocument.set_document_kind( Value: TDocumentSubKind );
begin
  Fdocument_kind := Value;
end;

procedure TDocument.set_doc_ind(value: integer);
begin
  Fdoc_ind := value;
end;

procedure TDocument.set_doc_state(value: TDocumentState);
begin
  FDocState := value;
end;

procedure TDocument.set_flag(value: TdocumentFlag );
begin
 Fflag := value;
end;

procedure TDocument.set_from_user( Value: IUserInfo );
begin
  Ffrom_user := Value;
end;




procedure TDocument.set_is_readen(value: boolean);
begin
  FisReaden := value;
end;

procedure TDocument.set_kind( Value: TDocumentKind );
begin
  Fkind := Value;
end;

procedure TDocument.set_make_date( Value: tdateTime );
begin
  Fmake_date := Value;
end;

procedure TDocument.set_owner_id(value: integer);
begin
  Fowner_id := value;
end;

procedure TDocument.set_pipe_ind(value: integer);
begin
  Fpipe_ind := value;
end;

procedure TDocument.set_send_date(value: TDateTime);
begin
  FsendDate := value;
end;

procedure TDocument.set_to_user(value: IUserInfo);
begin
  Fto_user := value;
end;


end.
