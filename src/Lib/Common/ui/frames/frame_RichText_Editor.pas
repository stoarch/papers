unit frame_RichText_Editor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Frame_Editor, ImgList, StdCtrls, ComCtrls,
  ExtCtrls, richEdit, shellApi, sStatusBar,
  sRichEdit, sBevel, sComboBox, sFontCtrls, Buttons, sSpeedButton, sPanel,
  sFrameAdapter;

type
  TRichText_EditorFrame = class(TEditorFrame)
    ToolbarImages: TImageList;
    sPanel1: TsPanel;
    CutButton: TsSpeedButton;
    CopyButton: TsSpeedButton;
    PasteButton: TsSpeedButton;
    UndoButton: TsSpeedButton;
    FontNameCombo: TsFontComboBox;
    FontSize: TsComboBox;
    BoldButton: TsSpeedButton;
    ItalicButton: TsSpeedButton;
    UnderlineButton: TsSpeedButton;
    LeftAlign: TsSpeedButton;
    CenterAlign: TsSpeedButton;
    RightAlign: TsSpeedButton;
    BulletsButton: TsSpeedButton;
    Ruler: TsPanel;
    RulerLine: TsBevel;
    FirstInd: TLabel;
    LeftInd: TLabel;
    RightInd: TLabel;
    Editor: TsRichEdit;
    StatusBar: TsStatusBar;
  private
    FInitializing : boolean;
    FUpdating: Boolean;
    FDragOfs: Integer;
    FDragging: Boolean;
    function get_content: string;
    procedure GetFontNames;
    procedure set_content(const Value: string);
    procedure SetEditRect;
    procedure SetupRuler;
    procedure UpdateCursorPos;
    { Private declarations }
  public
    { Public declarations }

    property Content : string read get_content write set_content;
    constructor Create(AOwner: TCOmponent);override;

  published
    procedure underlineButton1Click(Sender: TObject);
    procedure italicButton1Click(Sender: TObject);
    procedure LeftIndMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure RichEditChange(Sender: TObject);
    procedure RightIndMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure RulerItemMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure RulerItemMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure RulerResize(Sender: TObject);
    procedure SelectionChange(Sender: TObject);

    procedure AlignButtonClick(Sender: TObject);
    procedure BoldButton1Click(Sender: TObject);
    procedure bulletsButton1Click(Sender: TObject);
    function CurrText: TTextAttributes;
    procedure EditCopy(Sender: TObject);
    procedure EditCut(Sender: TObject);
    procedure EditPaste(Sender: TObject);
    procedure EditUndo(Sender: TObject);
    procedure FirstIndMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FontName1Change(Sender: TObject);
    procedure FontSize1Change(Sender: TObject);
    procedure FrameResize(Sender: TObject);
    procedure FrameShow(Sender: TObject);
  end;

var
  RichText_EditorFrame: TRichText_EditorFrame;

implementation

{$R *.dfm}
resourcestring
  sColRowInfo = 'Line: %3d   Col: %3d';

const
  RulerAdj = 4/3;
  GutterWid = 6;

procedure TRichText_EditorFrame.SelectionChange(Sender: TObject);
begin
  with Editor.Paragraph do
  try
    FUpdating := True;
    FirstInd.Left := Trunc(FirstIndent*RulerAdj)-4+GutterWid;
    LeftInd.Left := Trunc((LeftIndent+FirstIndent)*RulerAdj)-4+GutterWid;
    RightInd.Left := Ruler.ClientWidth-6-Trunc((RightIndent+GutterWid)*RulerAdj);
    BoldButton.Down := fsBold in Editor.SelAttributes.Style;
    ItalicButton.Down := fsItalic in Editor.SelAttributes.Style;
    UnderlineButton.Down := fsUnderline in Editor.SelAttributes.Style;
    BulletsButton.Down := Boolean(Numbering);
    FontSize.Text := IntToStr(Editor.SelAttributes.Size);

    if Editor.SelAttributes.Name <> '' then
      FontNameCombo.Text := Editor.SelAttributes.Name
    else
      FontNameCombo.Text := 'Verdana'
    ;

    case Ord(Alignment) of
      0: LeftAlign.Down := True;
      1: RightAlign.Down := True;
      2: CenterAlign.Down := True;
    end;
    UpdateCursorPos;
  finally
    FUpdating := False;
  end;
end;

function TRichText_EditorFrame.CurrText: TTextAttributes;
begin
  if Editor.SelLength > 0 then Result := Editor.SelAttributes
  else
   begin
     Editor.SelText := ' ';
     Editor.SelStart := Editor.SelStart - 1;
     Editor.SelLength := 1;

     Result := Editor.SelAttributes;
   end;//if
end;

function TRichText_EditorFrame.get_content: string;
  var
    stm : TStringStream;
begin
  result := '';

  stm := TStringStream.Create(result);
  try
    Editor.Lines.SaveToStream(stm);
    result := stm.DataString;
  finally
    if( assigned( stm ) )then
      FreeAndNil( stm );
  end;//try-finally
end;

procedure TRichText_EditorFrame.set_content(const Value: string);
  var
    stm : TStringStream;
begin
  FUpdating := true;

  stm := TStringStream.Create( value );
  try
    Editor.Lines.LoadFromStream( stm );
  finally
    if( assigned( stm ) )then
      FreeAndNil( stm );
  end;//try

  FUpdating := false;
end;

procedure TRichText_EditorFrame.GetFontNames;
begin
  //FontNameCombo.Items.Assign( Screen.Fonts );
  FontNameCombo.ItemIndex := FontNameCombo.Items.IndexOf('Verdana');
end;

procedure TRichText_EditorFrame.SetupRuler;
var
  I: Integer;
  S: String;
begin
  SetLength(S, 201);
  I := 1;
  while I < 200 do
  begin
    S[I] := #9;
    S[I+1] := '|';
    Inc(I, 2);
  end;
  Ruler.Caption := S;
end;

procedure TRichText_EditorFrame.SetEditRect;
var
  R: TRect;
begin
  with Editor do
  begin
    R := Rect(GutterWid, 0, ClientWidth-GutterWid, ClientHeight);
    SendMessage(Handle, EM_SETRECT, 0, Longint(@R));
  end;
end;

{ Event Handlers }

constructor TRichText_EditorFrame.Create(AOwner : TCOmponent);
begin
  inherited;

  FInitializing := true;

  GetFontNames;
  SetupRuler;
  SelectionChange(Self);

  CurrText.Name := 'Verdana';
  CurrText.Size := -8;

  FInitializing := false;
end;

procedure TRichText_EditorFrame.EditUndo(Sender: TObject);
begin
  with Editor do
    if HandleAllocated then SendMessage(Handle, EM_UNDO, 0, 0);
end;

procedure TRichText_EditorFrame.EditCut(Sender: TObject);
begin
  Editor.CutToClipboard;
end;

procedure TRichText_EditorFrame.EditCopy(Sender: TObject);
begin
  Editor.CopyToClipboard;
end;

procedure TRichText_EditorFrame.EditPaste(Sender: TObject);
begin
  Editor.PasteFromClipboard;
end;

procedure TRichText_EditorFrame.RulerResize(Sender: TObject);
begin
  RulerLine.Width := Ruler.ClientWidth - (RulerLine.Left*2);
end;

procedure TRichText_EditorFrame.FrameResize(Sender: TObject);
begin
  SetEditRect;
  SelectionChange(Sender);
end;

procedure TRichText_EditorFrame.BoldButton1Click(Sender: TObject);
begin
  if FUpdating then Exit;
  if BoldButton.Down then
    CurrText.Style := CurrText.Style + [ fsBold ]
  else
    CurrText.Style := CurrText.Style - [ fsBold ];
end;

procedure TRichText_EditorFrame.italicButton1Click(Sender: TObject);
begin
  if FUpdating then Exit;
  if ItalicButton.Down then
    CurrText.Style := CurrText.Style + [ fsItalic ]
  else
    CurrText.Style := CurrText.Style - [ fsItalic ];
end;

procedure TRichText_EditorFrame.FontSize1Change(Sender: TObject);
begin
  if FUpdating then Exit;
  CurrText.Size := StrToInt(FontSize.Text);
  Editor.SetFocus();
end;

procedure TRichText_EditorFrame.AlignButtonClick(Sender: TObject);
begin
  if FUpdating then Exit;
  Editor.Paragraph.Alignment := TAlignment(TControl(Sender).Tag);
end;

procedure TRichText_EditorFrame.FontName1Change(Sender: TObject);
begin
  if FUpdating or FInitializing then Exit;
  CurrText.Name := FontNameCombo.Items[FontNameCombo.ItemIndex];
  Editor.SetFocus();
end;

procedure TRichText_EditorFrame.underlineButton1Click(Sender: TObject);
begin
  if FUpdating then Exit;
  if UnderlineButton.Down then
    CurrText.Style := CurrText.Style +  [ fsUnderline ]
  else
    CurrText.Style := CurrText.Style -  [ fsUnderline ];
end;

procedure TRichText_EditorFrame.bulletsButton1Click(Sender: TObject);
begin
  if FUpdating then Exit;
  Editor.Paragraph.Numbering := TNumberingStyle(BulletsButton.Down);
end;

{ Ruler Indent Dragging }

procedure TRichText_EditorFrame.RulerItemMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  FDragOfs := (TLabel(Sender).Width div 2);
  TLabel(Sender).Left := TLabel(Sender).Left+X-FDragOfs;
  FDragging := True;
end;

procedure TRichText_EditorFrame.RulerItemMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  if FDragging then
    TLabel(Sender).Left :=  TLabel(Sender).Left+X-FDragOfs
end;

procedure TRichText_EditorFrame.FirstIndMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  FDragging := False;
  Editor.Paragraph.FirstIndent := Trunc((FirstInd.Left+FDragOfs-GutterWid) / RulerAdj);
  LeftIndMouseUp(Sender, Button, Shift, X, Y);
end;

procedure TRichText_EditorFrame.LeftIndMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  FDragging := False;
  Editor.Paragraph.LeftIndent := Trunc((LeftInd.Left+FDragOfs-GutterWid) / RulerAdj)-Editor.Paragraph.FirstIndent;
  SelectionChange(Sender);
end;

procedure TRichText_EditorFrame.RightIndMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  FDragging := False;
  Editor.Paragraph.RightIndent := Trunc((Ruler.ClientWidth-RightInd.Left+FDragOfs-2) / RulerAdj)-2*GutterWid;
  SelectionChange(Sender);
end;

procedure TRichText_EditorFrame.UpdateCursorPos;
var
  CharPos: TPoint;
begin
  CharPos.Y := SendMessage(Editor.Handle, EM_EXLINEFROMCHAR, 0,
    Editor.SelStart);
  CharPos.X := (Editor.SelStart -
    SendMessage(Editor.Handle, EM_LINEINDEX, CharPos.Y, 0));
  Inc(CharPos.Y);
  Inc(CharPos.X);
  statusBar.Panels[0].Text := Format(sColRowInfo, [CharPos.Y, CharPos.X]);
end;

procedure TRichText_EditorFrame.FrameShow(Sender: TObject);
begin
  UpdateCursorPos;
  DragAcceptFiles(Handle, True);

  RichEditChange(nil);
  Editor.SetFocus;
end;

procedure TRichText_EditorFrame.RichEditChange(Sender: TObject);
begin
  if(not FInitializing)and( not FUpdating )and( Editor.Modified )then
    data_changed := true;
end;



end.
