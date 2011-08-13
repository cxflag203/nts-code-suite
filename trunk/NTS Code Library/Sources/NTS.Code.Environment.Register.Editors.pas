unit NTS.Code.Environment.Register.Editors;

interface

Uses
  Classes, DesignIntf, TypInfo, DesignEditors,
  NTS.Code.Common.Types, NTS.Code.Environment.PropertyEditors;
  
  Procedure Register;

implementation


Procedure Register;
begin
  RegisterPropertyEditor(TypeInfo(TFileName), nil, '', TFileNameEditor);
  RegisterPropertyEditor(TypeInfo(TImageFileName), nil,'',TImageFileNameEditor);
end;

end.
