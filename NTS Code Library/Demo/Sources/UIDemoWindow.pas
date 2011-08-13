unit UIDemoWindow;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, NTS.Code.Components.WindowConfig,
  NTS.Code.Components.VirtualStringList;

type
  TDemoWindow = class(TForm)
    WindowConfig: TWindowConfig;
    GroupBox1: TGroupBox;
    CheckBox1: TCheckBox;
    Button1: TButton;
    procedure CheckBox1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DemoWindow: TDemoWindow;

implementation

{$R *.dfm}

procedure TDemoWindow.Button1Click(Sender: TObject);
begin
  with TOpenDialog.Create(Application) do
  begin
    Filter:= 'Icon|*.ico';
    if Execute() then
      WindowConfig.Icon:= FileName;
    Free;
  end;
end;

procedure TDemoWindow.CheckBox1Click(Sender: TObject);
begin
  WindowConfig.ShowCaptionBar:= CheckBox1.Checked;
end;

end.
