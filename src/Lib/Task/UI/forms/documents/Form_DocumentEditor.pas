unit Form_DocumentEditor;

interface

uses
  //-- common --
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Form_Skined, Frame_Skined, Frame_DocumentEditor, ImgList,
  ExtCtrls, sSkinProvider, StdCtrls, sButton, sPanel,
  ComCtrls, sStatusBar, sDialogs,
  //--[ constants ]--
  const_document,
  const_user,
  const_userInfo,
  //--[ factories ]--
  factory_documents,
  factory_users,
  //--[ frames ]--
  Frame_Editor,
  Frame_ContainerEditor,
  //--[ interfaces ]--
  interface_document,
  interface_userData
  ;

type
  //****************************************************************************
  // kind: class
  // goal: provide the ability of editing the document
  // scenary:
  //  1. make an instance
  //  2. set user data
  //  3. set document data
  //  4. execute and check state of it (true - all ok)
  TDocumentEditorForm = class(TSkinedForm)
    functions_ImageList: TImageList;
    document_editor_frame: Tdocument_editor_frame;
    sPanel1: TsPanel;
    button_save: TsButton;
    Cancel_Button: TsButton;
    status_bar: TsStatusBar;
    procedure button_cancelClick(Sender: TObject);
    procedure button_saveClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    Fdocument: IDocument;
    m_changed : boolean;
    FuserData: IUserData;

    procedure Setdocument(const Value: IDocument);
    procedure update_document_from_editor;
    { Private declarations }

    procedure Handle_DataChanged( sender : tobject );
    procedure setData_Changed(const Value: boolean);
    procedure update_interface;
    procedure SetuserData(const Value: IUserData);

  protected

    property data_changed : boolean read m_changed write setData_Changed;
  public
    { Public declarations }
    constructor Create( AOwner : TComponent );override;
    destructor Destroy();override;

    //--[ methods ]--
    function execute() : boolean;

    //--[ properties ]--
    property isChanged : boolean read m_changed;
    property document : IDocument read Fdocument write Setdocument;
    property userData : IUserData read FuserData write SetuserData;
  end;

var
  DocumentEditorForm: TDocumentEditorForm;

implementation

uses Paperwork_ClassFactory;

{$R *.dfm}

{ TDocumentEditorForm }

function TDocumentEditorForm.execute: boolean;
begin
  result := ShowModal() = mrOk;
end;

procedure TDocumentEditorForm.Setdocument(const Value: IDocument);
begin
  Fdocument := ( Value );

  data_changed   := false;
  update_interface();
end;


procedure TDocumentEditorForm.button_cancelClick(Sender: TObject);
begin
  inherited;
  ModalResult := mrCancel;
end;

procedure TDocumentEditorForm.button_saveClick(Sender: TObject);
begin
  inherited;

  update_document_from_editor();

  m_changed := false;

  ModalResult := mrOk;
end;

procedure TDocumentEditorForm.update_interface();
begin
  document_editor_frame.document := Fdocument;
end;


procedure TDocumentEditorForm.update_document_from_editor();
begin
  FDocument := ( document_editor_frame.document );
end;


constructor TDocumentEditorForm.Create(AOwner: TComponent);
begin
  inherited;

  Fdocument := documents_factory.createInstance( CLSID_DOCUMENT, IID_IDocument ) as IDocument;
  FuserData := users_factory.createInstance( CLSID_USERDATA, IID_IUserData ) as IUserData;

  document_editor_frame.OnDataChanged := Handle_DataChanged;
end;

procedure TDocumentEditorForm.Handle_DataChanged(sender: tobject);
begin
  data_changed := true;
end;

procedure TDocumentEditorForm.setData_Changed(const Value: boolean);
begin
  m_changed := value;

  button_save.enabled := m_changed;

  if( m_changed )then
   begin
     status_bar.panels[0].text:= '��������';
   end
  else
   begin
     status_bar.panels[0].text := '������';
   end;//if--else
end;

procedure TDocumentEditorForm.SetuserData(const Value: IUserData);
begin
  FuserData := ( Value );

  document_editor_frame.user := value;
end;

destructor TDocumentEditorForm.Destroy;
begin
  FuserData := nil;
  Fdocument := nil;

  inherited;
end;

procedure TDocumentEditorForm.FormActivate(Sender: TObject);
begin
  left   := screen.desktopLeft;
  top    := screen.desktopTop;
  width  := screen.desktopWidth;
  height := screen.DesktopHeight;
end;

procedure TDocumentEditorForm.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  case key of
    VK_ESCAPE : close();
  end;//case

end;

procedure TDocumentEditorForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  canClose := true;
  if m_changed then
  if sMessageDlg( '����� ��� ����������?', mtConfirmation, [mbYes,mbNo],0) = id_no then
    canClose := false;
end;

end.
