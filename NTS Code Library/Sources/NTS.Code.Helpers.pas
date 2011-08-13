{*******************************************************}
{                                                       }
{                    NTS Code Library                   }
{         Created by GooD-NTS ( good.nts@gmail.com )    }
{           http://ntscorp.ru/  Copyright(c) 2011       }
{          License: Mozilla Public License 1.1          }
{                                                       }
{*******************************************************}

unit NTS.Code.Helpers;

interface

Uses
  SysUtils, Windows, Classes, Math;

type
  TPointHelper = Record Helper for TPoint
    function InRect(ARect: TRect): BooLean; InLine;
    function ToString: String;
    Procedure FromString(AX,AY: String);
  end;

  TSizeHelper = Record Helper for TSize
    Procedure Make(Width,Height: Integer); InLine;
    function IsValue(Value: Integer): BooLean;  InLine;
  End;

implementation

{ TPointHelper }

procedure TPointHelper.FromString(AX, AY: String);
begin
  Self.X:= StrToInt(AX);
  Self.Y:= StrToInt(AY);
end;

function TPointHelper.InRect(ARect: TRect): BooLean;
begin
  Result:= Windows.PtInRect(ARect,Self);
end;

function TPointHelper.ToString: String;
begin
  Result:= IntToStr(Self.X)+','+IntToStr(Self.Y);
end;

{ TSizeHelper }

function TSizeHelper.IsValue(Value: Integer): BooLean;
begin
  Result:= (cx = Value) and (cy = Value);
end;

procedure TSizeHelper.Make(Width, Height: Integer);
begin
  cx:= Width;
  cy:= Height;
end;

end.
