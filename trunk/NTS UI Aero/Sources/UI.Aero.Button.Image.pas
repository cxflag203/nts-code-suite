unit UI.Aero.Button.Image;

interface

uses
  SysUtils, Windows, Messages, Classes, Controls, Graphics, CommCtrl, Types,
  Themes, UxTheme, DwmApi, PNGImage, NTS.Code.Common.Types, UI.Aero.Core.BaseControl,
  StdCtrls, Forms, GDIPUTIL, GDIPOBJ, GDIPAPI, UI.Aero.Core.CustomControl.Animation,
  UI.Aero.Button.Custom, UI.Aero.Core.Images, UI.Aero.Globals;

type
  TAeroImageButton = Class(TAeroCustomImageButton)
  Protected
    function GetRenderState: TARenderConfig; override;
    function CanAutoSize(var NewWidth, NewHeight: Integer): Boolean; override;
    procedure RenderState(const PaintDC: hDC; var Surface: TGPGraphics; var RConfig: TARenderConfig; const DrawState: Integer); override;
    procedure ClassicRender(const ACanvas: TCanvas; const DrawState: Integer); override;
  Published
    Property AutoSize;
  End;

implementation

{ TAeroImageButton }

function TAeroImageButton.GetRenderState: TARenderConfig;
begin
 Result:= [];
end;

function TAeroImageButton.CanAutoSize(var NewWidth, NewHeight: Integer): Boolean;
begin
 Result:= True;
 if Image.DataLoaded then
  begin
   NewWidth:= Image.PartWidth;
   NewHeight:= Image.PartHeight;
  end;
end;

procedure TAeroImageButton.ClassicRender(const ACanvas: TCanvas; const DrawState: Integer);
begin
 if Image.DataLoaded then
  case TAeroButtonState(DrawState) of
    bsNormal    : AeroPicture.DrawPart(ACanvas.Handle,Image.Data.Canvas.Handle,Point(0,0),Image.PartSize,Image.PartNormal,Image.Orientation);
    bsHightLight: AeroPicture.DrawPart(ACanvas.Handle,Image.Data.Canvas.Handle,Point(0,0),Image.PartSize,Image.PartHightLight,Image.Orientation);
    bsFocused   : AeroPicture.DrawPart(ACanvas.Handle,Image.Data.Canvas.Handle,Point(0,0),Image.PartSize,Image.PartFocused,Image.Orientation);
    bsDown      : AeroPicture.DrawPart(ACanvas.Handle,Image.Data.Canvas.Handle,Point(0,0),Image.PartSize,Image.PartDown,Image.Orientation);
    bsDisabled  : AeroPicture.DrawPart(ACanvas.Handle,Image.Data.Canvas.Handle,Point(0,0),Image.PartSize,Image.PartDisabled,Image.Orientation);
  end;
end;

procedure TAeroImageButton.RenderState(const PaintDC: hDC; var Surface: TGPGraphics; var RConfig: TARenderConfig; const DrawState: Integer);
begin
 if Image.DataLoaded then
  case TAeroButtonState(DrawState) of
    bsNormal    : AeroPicture.DrawPart(PaintDC,Image.Data.Canvas.Handle,Point(0,0),Image.PartSize,Image.PartNormal,Image.Orientation);
    bsHightLight: AeroPicture.DrawPart(PaintDC,Image.Data.Canvas.Handle,Point(0,0),Image.PartSize,Image.PartHightLight,Image.Orientation);
    bsFocused   : AeroPicture.DrawPart(PaintDC,Image.Data.Canvas.Handle,Point(0,0),Image.PartSize,Image.PartFocused,Image.Orientation);
    bsDown      : AeroPicture.DrawPart(PaintDC,Image.Data.Canvas.Handle,Point(0,0),Image.PartSize,Image.PartDown,Image.Orientation);
    bsDisabled  : AeroPicture.DrawPart(PaintDC,Image.Data.Canvas.Handle,Point(0,0),Image.PartSize,Image.PartDisabled,Image.Orientation);
  end;
end;

end.
