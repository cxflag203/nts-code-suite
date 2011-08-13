{*******************************************************}
{                                                       }
{                    NTS Code Library                   }
{         Created by GooD-NTS ( good.nts@gmail.com )    }
{           http://ntscorp.ru/  Copyright(c) 2011       }
{          License: Mozilla Public License 1.1          }
{                                                       }
{*******************************************************}

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
