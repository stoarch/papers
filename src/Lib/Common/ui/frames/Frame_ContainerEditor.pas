unit Frame_ContainerEditor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Frame_Editor, sFrameAdapter;

type
  TContainerEditorFrame = class(TEditorFrame)
  private
    { Private declarations }
  protected
    procedure Handle_DataChanged(sender: TObject);virtual;
  public
    { Public declarations }
  end;

var
  ContainerEditorFrame: TContainerEditorFrame;

implementation

{$R *.dfm}

{ TContainerEditorFrame }

procedure TContainerEditorFrame.Handle_DataChanged(sender: TObject);
begin
  data_changed := true;
end;

end.
