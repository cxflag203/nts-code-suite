{*******************************************************}
{                                                       }
{                   NTS Aero UI Library                 }
{         Created by GooD-NTS ( good.nts@gmail.com )    }
{           http://ntscorp.ru/  Copyright(c) 2011       }
{          License: Mozilla Public License 1.1          }
{                                                       }
{*******************************************************}

unit UI.Aero.Button;

interface

{$I '../../Common/CompilerVersion.Inc'}

uses
  {$IFDEF HAS_UNITSCOPE}
  System.SysUtils,
  System.Classes,
  Winapi.Windows,
  Winapi.Messages,
  Winapi.UxTheme,
  Winapi.DwmApi,
  Winapi.GDIPAPI,
  Winapi.GDIPOBJ,
  Winapi.GDIPUTIL,
  Winapi.CommCtrl,
  Vcl.Controls,
  Vcl.Graphics,
  Vcl.Themes,
  Vcl.Imaging.pngimage,
  Vcl.StdCtrls,
  {$ELSE}
  SysUtils, Windows, Messages, Classes, Controls, Graphics, CommCtrl,
  Themes, UxTheme, DwmApi, PNGImage, StdCtrls, Winapi.GDIPAPI, Winapi.GDIPOBJ,
  Winapi.GDIPUTIL,
  {$ENDIF}
  NTS.Code.Common.Types,
  UI.Aero.Core.BaseControl,
  UI.Aero.Core.CustomControl.Animation,
  UI.Aero.Button.Custom,
  UI.Aero.Globals,
  UI.Aero.Core;


type
  TCustomAeroButton = Class(TAeroCustomButton)
  private
    fFlatStyle: boolean;
    procedure setFlatStyle(const Value: boolean);
  Protected
    function GetRenderState: TARenderConfig; override;
    function GetThemeClassName: PWideChar; override;
    procedure RenderState(const PaintDC: hDC; var Surface: TGPGraphics; var RConfig: TARenderConfig; const DrawState: Integer); override;
    procedure ClassicRender(const ACanvas: TCanvas; const DrawState: Integer); override;
  published
    
  Public
    Constructor Create(AOwner: TComponent); OverRide;
  Published
    property DesigningRect Default False;
    property AnimationDuration Default 250;
    property FlatStyle: boolean read fFlatStyle write setFlatStyle Default False;
  End;

  TAeroButton = class(TCustomAeroButton)
  const
    TextFormat = (DT_CENTER or DT_VCENTER or DT_SINGLELINE);
  Protected
    procedure PostRender(const Surface: TCanvas;const RConfig: TARenderConfig; const DrawState: Integer); override;
    procedure RenderState(const PaintDC: hDC; var Surface: TGPGraphics; var RConfig: TARenderConfig; const DrawState: Integer); override;
    procedure ClassicRender(const ACanvas: TCanvas; const DrawState: Integer); override;
  Published
    property Caption;
  end;

implementation

Uses
  UI.Aero.Window;

{ TCustomAeroButton }

Constructor TCustomAeroButton.Create(AOwner: TComponent);
begin
 Inherited Create(AOwner);
 DesigningRect:= False;
 AnimationDuration:= 250;
 fFlatStyle:= false;
 Width:= 75;
 Height:= 25;
end;

function TCustomAeroButton.GetRenderState: TARenderConfig;
begin
 Result:= [];
end;

function TCustomAeroButton.GetThemeClassName: PWideChar;
begin
 Result:= VSCLASS_BUTTON;
end;

procedure TCustomAeroButton.ClassicRender(const ACanvas: TCanvas; const DrawState: Integer);
var
 StateID: Integer;
 clRect: TRect;
begin
 StateID:= DFCS_HOT;
 case TAeroButtonState(DrawState) of
   bsNormal    : StateID:= DFCS_BUTTONPUSH or DFCS_HOT;
   bsHightLight: StateID:= DFCS_BUTTONPUSH or DFCS_HOT;
   bsFocused   : StateID:= DFCS_BUTTONPUSH or DFCS_HOT;
   bsDown      : StateID:= DFCS_BUTTONPUSH or DFCS_PUSHED;
   bsDisabled  :
    begin
     StateID:= DFCS_BUTTONPUSH or DFCS_FLAT;
     ACanvas.Font.Color:= clGrayText;
    end;
 end;
 clRect:= GetClientRect;
 DrawFrameControl(ACanvas.Handle,clRect,DFC_BUTTON,StateID);
end;

procedure TCustomAeroButton.RenderState(const PaintDC: hDC; var Surface: TGPGraphics; var RConfig: TARenderConfig; const DrawState: Integer);
var
 PartID,
 StateID: Integer;
 clRect: TRect;
begin
 clRect:= GetClientRect;
 if fFlatStyle then
  begin
   if AeroCore.RunWindowsVista then
    PartID:= BP_COMMANDLINK
   else
    PartID:= BP_PUSHBUTTON;
  end
 else
  PartID:= BP_PUSHBUTTON;
 StateID:= PBS_NORMAL;
 case TAeroButtonState(DrawState) of
   bsNormal    : StateID:= PBS_NORMAL;
   bsHightLight: StateID:= PBS_HOT;
   bsFocused   : StateID:= PBS_DEFAULTED;
   bsDown      : StateID:= PBS_PRESSED;
   bsDisabled  : StateID:= PBS_DISABLED;
 end;
 DrawThemeBackground(ThemeData,PaintDC,PartID,StateID,clRect,@clRect);
end;

procedure TCustomAeroButton.setFlatStyle(const Value: boolean);
begin
 if fFlatStyle <> Value then
  begin
   fFlatStyle:= Value;
   Invalidate;
  end;
end;

{ TAeroButton }

procedure TAeroButton.PostRender(const Surface: TCanvas; const RConfig: TARenderConfig; const DrawState: Integer);
begin

end;

procedure TAeroButton.RenderState(const PaintDC: hDC; var Surface: TGPGraphics; var RConfig: TARenderConfig; const DrawState: Integer);
var
 PartID, StateID: Integer;
begin
 Inherited RenderState(PaintDC,Surface,RConfig,DrawState);
 PartID:= BP_PUSHBUTTON;
 StateID:= PBS_NORMAL;
 case TAeroButtonState(DrawState) of
   bsNormal    : StateID:= PBS_NORMAL;
   bsHightLight: StateID:= PBS_HOT;
   bsFocused   : StateID:= PBS_DEFAULTED;
   bsDown      : StateID:= PBS_PRESSED;
   bsDisabled  : StateID:= PBS_DISABLED;
 end;
 AeroCore.RenderText(PaintDC,ThemeData,PartID,StateID,Self.Font,TextFormat,GetClientRect,Caption,False);
end;

procedure TAeroButton.ClassicRender(const ACanvas: TCanvas; const DrawState: Integer);
var
 clRect: TRect;
begin
 Inherited ClassicRender(ACanvas,DrawState);
 clRect:= GetClientRect;
 clRect:= Rect(clRect.Left+3,clRect.Top+3,clRect.Right-3,clRect.Bottom-3);
 AeroCore.RenderText(ACanvas.Handle,Self.Font,TextFormat,clRect,Caption);
 if Focused then ACanvas.DrawFocusRect(clRect);
end;

end.
