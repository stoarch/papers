unit Frame_OfficeManager_Workplace;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Frame_PaperworkUser_Workplace, ImgList,
  Frame_Skined, FlexCompress, Menus,
  ExtCtrls, frame_document_view, ComCtrls, ActnList,
  sFrameAdapter, ToolWin, sToolBar, sTreeView, sListView, StdCtrls,
  sGroupBox, sPanel, sSplitter;

type
  TOfficeManagerWorkplace = class(TPaperworkUser_Workplace)
  private
    { Private declarations }
  public
    { Public declarations }
    constructor Create( AOwner : TComponent );override;
    destructor Destroy();override;
  end;

var
  OfficeManagerWorkplace: TOfficeManagerWorkplace;

implementation

{$R *.dfm}

{ TOfficeManagerWorkplace }

constructor TOfficeManagerWorkplace.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TOfficeManagerWorkplace.Destroy;
begin

  inherited;
end;

end.
