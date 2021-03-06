unit Frame_DocumentAttachments_Editor;

interface

uses
  //--[ common ]--
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Frame_Skined, ComCtrls, ImgList,
  ExtCtrls, sDialogs,
  //--[ constants ]--
  const_documentAttachmentList,
  //--[ factories ]--
  factory_documents,
  //--[ forms ]--
  Form_DocumentAttachmentEditor,
  //--[ frames ]--
  frame_Editor,
  //--[ interfaces ]--
  interface_documentAttachment,
  interface_documentAttachmentList, sPanel, sListView,
  StdCtrls, sGroupBox, ToolWin, sToolBar, sFrameAdapter
  ;

type
  Tdocument_attachments_editor = class(TEditorFrame)
    functions_imageList: TImageList;
    functions_toolbar: TsToolBar;
    add_button: TToolButton;
    edit_button: TToolButton;
    delete_button: TToolButton;
    ToolButton4: TToolButton;
    attach_groupBox: TsGroupBox;
    attachments_list_view: TsListView;
    urn_label: TsPanel;
    procedure add_button1Click(Sender: TObject);
    procedure attachments_list_view1Click(Sender: TObject);
    procedure edit_button1Click(Sender: TObject);
    procedure delete_button1Click(Sender: TObject);
  private
    Fattachment: integer;
    Fattachment_list: IDocumentAttachmentList;
    
    procedure Setattachment(const Value: integer);
    procedure Setattachment_list(const Value: IDocumentAttachmentList);
    procedure add_attachment;
    procedure load_ui_from_list(list: IDocumentAttachmentList);
    procedure add_visual_attachment(attachment: IDocumentAttachment);
    procedure edit_active_attachment;
    function edit_attachment(
      attachment: IDocumentAttachment): IDocumentAttachment;
    procedure delete_attachment;
    { Private declarations }
  public
    constructor Create( AOwner : TComponent );override;
    destructor Destroy();override;

    { Public declarations }
    procedure initialize;override;

    //--[ properties ]--
    property attachment_list : IDocumentAttachmentList read Fattachment_list write Setattachment_list;
    property attachment : integer read Fattachment write Setattachment;
  end;

var
  document_attachments_editor: Tdocument_attachments_editor;

implementation


uses Paperwork_ClassFactory,
  const_documentAttachment;


{$R *.dfm}
{ Tdocument_attachments_editor }

constructor Tdocument_attachments_editor.Create(AOwner: TComponent);
begin
  inherited;

  initialize();
end;

procedure Tdocument_attachments_editor.initialize();
begin
  Fattachment_list := documents_factory.createInstance( CLSID_DOCUMENT_ATTACHMENT_LIST, IID_IDocumentAttachmentList ) as IDocumentAttachmentList;
end;


destructor Tdocument_attachments_editor.Destroy;
begin
  Fattachment_list := nil;

  inherited;
end;

procedure Tdocument_attachments_editor.Setattachment(const Value: integer);
begin
  Fattachment := Value;

  if( 0 = attachments_list_view.items.count )then
    exit;

  if( value >= 0 )then
    begin
      edit_button.Enabled := true;
      delete_button.Enabled := true;
    end
  else
    begin
      urn_label.caption := '�������� ������� ��� ���������';
      edit_button.Enabled := false;
      delete_button.Enabled := false;
    end;//if

  if( value < 0 )or( value >= attachments_list_view.items.count )then
    exit;

  attachments_list_view.ItemIndex := value;
  urn_label.caption := Fattachment_list.Attachments[ value ].doc_file;
end;

procedure Tdocument_attachments_editor.Setattachment_list(
  const Value: IDocumentAttachmentList);
begin
  Fattachment_list := ( Value );

  load_ui_from_list( value );
end;

procedure Tdocument_attachments_editor.add_button1Click(Sender: TObject);
begin
  inherited;

  add_attachment();
end;

procedure Tdocument_attachments_editor.add_attachment();
  var
    attachment : IDocumentAttachment;
begin
  attachment := documents_factory.createInstance( CLSID_DOCUMENT_ATTACHMENT, IID_IDocumentAttachment ) as IDocumentAttachment;

  attachment := edit_attachment( attachment );

  if( attachment <> nil )then
  begin
    Fattachment_list.Add( attachment );

    add_visual_attachment( attachment );
    Setattachment( Fattachment_list.Count - 1);

    data_changed := true;
  end;//if
end;

procedure Tdocument_attachments_editor.load_ui_from_list( list : IDocumentAttachmentList );
  var
    i : integer;
begin
  attachments_list_view.items.clear();
  for i := 0 to list.count - 1 do
  begin
    add_visual_attachment( list.Attachments[ i ] );
  end;//for
end;


procedure Tdocument_attachments_editor.add_visual_attachment( attachment : IDocumentAttachment);
 var
   item : TlistItem;
begin
  item := attachments_list_view.items.Add;
  item.Caption := attachment.caption;
  item.ImageIndex := 3;
end;



procedure Tdocument_attachments_editor.attachments_list_view1Click(
  Sender: TObject);
begin
  inherited;
  Setattachment( attachments_list_view.ItemIndex );
end;

procedure Tdocument_attachments_editor.edit_button1Click(Sender: TObject);
begin
  inherited;

  edit_active_attachment();
end;

procedure Tdocument_attachments_editor.edit_active_attachment();
  var
    attachment :  IDocumentAttachment;
begin
  attachment := Fattachment_list.Attachments[ attachments_list_view.itemIndex ];

  attachment := edit_attachment( attachment );

  if( attachment <> nil )then
  begin
    Fattachment_list.Attachments[ attachments_list_view.itemIndex ] := attachment;
    Setattachment( attachments_list_view.itemIndex );

    attachments_list_view.items[ attachments_list_view.itemIndex ].caption := attachment.caption;

    data_changed := true;
  end;//if
end;//proc

function Tdocument_attachments_editor.edit_attachment( attachment : IDocumentAttachment ) : IDocumentAttachment;
  var
    editor : TDocumentAttachment_EditorForm;
begin
  editor := TDocumentAttachment_EditorForm.create( self );

  editor.attachment := attachment;

  result := nil;
  try
    if( editor.execute() )then
    begin
      result := editor.attachment;
    end;//if
  finally
    FreeAndNil( editor );
  end;//try--finally
end;//proc

procedure Tdocument_attachments_editor.delete_button1Click(Sender: TObject);
begin
  inherited;

  delete_attachment();
end;

procedure Tdocument_attachments_editor.delete_attachment();
begin
  if( sMessageDlg( '������� ����������?', mtConfirmation, [mbYes,mbNo], 0 ) = mrYes )then
  begin
    Fattachment_list.Delete( attachments_list_view.itemIndex );
    attachments_list_view.items.Delete( attachments_list_view.itemIndex );

    if( Fattachment_list.count = 0 )then
    begin
      delete_button.enabled := false;
      edit_button.Enabled   := false;
    end;//if

    data_changed := true;
  end;//if
end;


end.
