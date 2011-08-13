{*******************************************************}
{                                                       }
{                    NTS Code Library                   }
{         Created by GooD-NTS ( good.nts@gmail.com )    }
{           http://ntscorp.ru/  Copyright(c) 2011       }
{          License: Mozilla Public License 1.1          }
{                                                       }
{*******************************************************}

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
