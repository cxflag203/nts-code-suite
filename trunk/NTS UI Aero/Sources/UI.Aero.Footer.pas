{*******************************************************}
{                                                       }
{                   NTS Aero UI Library                 }
{         Created by GooD-NTS ( good.nts@gmail.com )    }
{           http://ntscorp.ru/  Copyright(c) 2011       }
{          License: Mozilla Public License 1.1          }
{                                                       }
{*******************************************************}

unit UI.Aero.Footer;

interface

uses
  SysUtils, Windows, Messages, Classes, Controls, Graphics, UxTheme,
  UI.Aero.Globals, UI.Aero.Core, UI.Aero.ThemeElement, GDIPOBJ, Forms;

type
  TAeroFooter = class(TAeroThemeElement)
  Private
    function UseWhiteColor: Boolean;
  Protected
    procedure ClassicRender(const ACanvas: TCanvas); OverRide;
    procedure ThemedRender(const PaintDC: hDC; const Surface: TGPGraphics; var RConfig: TRenderConfig); OverRide;
  Public
    Constructor Create(AOwner: TComponent); OverRide;
  Published
    property PartID Default 4;
    property StateID Default 1;
    property Height Default 41;
    property Align Default alBottom;
    property DesigningRect Default False;
  end;

implementation

{ TAeroFooter }

procedure TAeroFooter.ClassicRender(const ACanvas: TCanvas);
begin
 if UseWhiteColor then
  ACanvas.Brush.Color:= clWhite
 else
  ACanvas.Brush.Color:= clBtnFace;

 ACanvas.FillRect(ClientRect);
 ACanvas.Pen.Color:= clBtnShadow;
 ACanvas.MoveTo(0,0);
 ACanvas.LineTo(Width,0);
 Inherited ClassicRender(ACanvas);
end;

Constructor TAeroFooter.Create(AOwner: TComponent);
begin
 Inherited Create(AOwner);
 ControlStyle:= ControlStyle+[csAcceptsControls];
 ThemeClassName:= 'AeroWizard';
 PartID:= 4;
 StateID:= 1;
 Height:= 41;
 Align:= alBottom;
 DesigningRect:= False;
end;

procedure TAeroFooter.ThemedRender(const PaintDC: hDC; const Surface: TGPGraphics; var RConfig: TRenderConfig);
var
 clRect: TRect;
 PaintSurface: TCanvas;
begin
 clRect:= GetClientRect;
 if ThemeData <> 0 then
  DrawThemeBackground(ThemeData,PaintDC,PartID,StateID,clRect,@clRect)
 else
  begin
   PaintSurface:= TCanvas.Create;
   PaintSurface.Handle:= PaintDC;
   ClassicRender(PaintSurface);
   PaintSurface.Handle:= 0;
   PaintSurface.Free;
  end;
end;

function TAeroFooter.UseWhiteColor: Boolean;
begin
 Result:= False;
 if Parent is TForm then
  Result:= (TForm(Parent).Color = clBtnFace);
end;

end.
