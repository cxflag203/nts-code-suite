{*******************************************************}
{                                                       }
{                    NTS Code Library                   }
{         Created by GooD-NTS ( good.nts@gmail.com )    }
{           http://ntscorp.ru/  Copyright(c) 2011       }
{          License: Mozilla Public License 1.1          }
{                                                       }
{*******************************************************}

unit NTS.Code.Environment.PropertyEditors;

interface

{$I '../../Common/CompilerVersion.Inc'}

Uses
  {$IFDEF HAS_UNITSCOPE}
  System.Classes, System.TypInfo,
  Vcl.Dialogs, Vcl.ExtDlgs, Vcl.Forms, Vcl.ComCtrls,
  {$ELSE}
  Classes, TypInfo, Dialogs, ExtDlgs, Forms, ComCtrls,
  {$ENDIF}
  DesignIntf,  DesignEditors, ColnEdit;

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
