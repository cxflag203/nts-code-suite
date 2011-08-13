unit NTS.Code.Environment.Register.Components;

interface

uses
  Classes,
  NTS.Code.Components.VirtualStringList,
  NTS.Code.Components.WindowConfig;

  procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('NTS Base', [TVirtualStringList]);
  RegisterComponents('NTS Base', [TWindowConfig]);
end;

end.
