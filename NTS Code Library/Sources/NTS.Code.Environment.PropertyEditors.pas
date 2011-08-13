unit NTS.Code.Environment.PropertyEditors;

interface

Uses
  Classes, DesignIntf, TypInfo, DesignEditors, Dialogs,
  ExtDlgs, Forms, ColnEdit, ComCtrls;

type
  TFileNameEditor = class(TStringProperty)
  Protected
    function CreateDialog: TOpenDialog; Virtual;
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
  end;

  TImageFileNameEditor = class(TFileNameEditor)
  Protected
    function CreateDialog: TOpenDialog; override;
  end;

implementation

{ TFileNameEditor }

function TFileNameEditor.CreateDialog: TOpenDialog;
begin
  Result:= TOpenDialog.Create(Application);
end;

Procedure TFileNameEditor.Edit;
begin
  with CreateDialog do
  begin
    FileName:= GetValue;
    Options:= Options+[ofPathMustExist, ofFileMustExist];
    try
      if Execute then
        SetValue(FileName);
    finally
      Free;
    end;
  end;
end;

Function TFileNameEditor.GetAttributes: TPropertyAttributes;
begin
  Result:= [paDialog, paRevertable];
end;

{ TImageFileNameEditor }

function TImageFileNameEditor.CreateDialog: TOpenDialog;
begin
  Result:= TOpenPictureDialog.Create(Application);
end;

end.
