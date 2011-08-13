{*******************************************************}
{                                                       }
{                   NTS Aero UI Library                 }
{         Created by GooD-NTS ( good.nts@gmail.com )    }
{           http://ntscorp.ru/  Copyright(c) 2011       }
{          License: Mozilla Public License 1.1          }
{                                                       }
{*******************************************************}

unit UI.Aero.SearchBox;

interface

uses
  SysUtils, Windows, Messages, Classes, Controls, Graphics, CommCtrl,
  Themes, UxTheme, DwmApi, PNGImage, NTS.Code.Common.Types, UI.Aero.Core.BaseControl,
  StdCtrls, Forms, GDIPUTIL, GDIPOBJ, GDIPAPI, UI.Aero.Core.CustomControl,
  UI.Aero.Globals;

type
  TAeroSearchBox = class(TCustomAeroControl)
  Private
    StateID: Integer;
    EditControl: TEdit;
    EditControlWindowProc: TWndMethod;
    fBannerText: String;
    function GetEditTest: String;
    procedure SetEditText(const Value: String);
    function GetEditChangeEvent: TNotifyEvent;
    procedure SetEditChangeEvent(const Value: TNotifyEvent);
    procedure SetBannerText(const Value: String);
    procedure FixGlassPaint;
    function GetEditKeyDownEvent: TKeyEvent;
    function GetEditKeyPressEvent: TKeyPressEvent;
    function GetEditKeyUpEvent: TKeyEvent;
    procedure SetEditKeyPressEvent(const Value: TKeyPressEvent);
    procedure SetEditKeyUpEvent(const Value: TKeyEvent);
    procedure SetEditKeyDownEvent(const Value: TKeyEvent);//;cs
  Protected
    Function GetRenderState: TRenderConfig; override;
    procedure ThemedRender(const PaintDC: hDC; const Surface: TGPGraphics; var RConfig: TRenderConfig); OverRide;
    procedure ClassicRender(const ACanvas: TCanvas); override;
    procedure EditWindowProc(var Message: TMessage);
    procedure SetParent(AParent: TWinControl); override;
    procedure SetEditTheme;
    procedure WndProc(var Message: TMessage); override;
    procedure SetEnabled(Value: Boolean); override;
    function GetThemeClassName: PWideChar; override;
  Public
    function EditHandle: THandle;
    function GetEditControl: TEdit;
    Constructor Create(AOwner: TComponent); OverRide;
    Destructor Destroy; OverRide;
  Published
    Property Text: String Read GetEditTest Write SetEditText;
    Property DesigningRect Default False;
    Property BannerText: String read fBannerText Write SetBannerText;

    Property OnTextChange: TNotifyEvent Read GetEditChangeEvent Write SetEditChangeEvent;
    property OnKeyDown: TKeyEvent read GetEditKeyDownEvent write SetEditKeyDownEvent;
    property OnKeyPress: TKeyPressEvent read GetEditKeyPressEvent write SetEditKeyPressEvent;
    property OnKeyUp: TKeyEvent read GetEditKeyUpEvent write SetEditKeyUpEvent;
  End;

implementation

Uses
  UI.Aero.Window;

{ From CommCtrl.h }

function Edit_SetCueBannerTextFocused(hwnd: HWND; lpcwText: PChar;fDrawFocused: Bool): Bool;
begin
  Result:= Bool(SendMessage(hwnd, EM_SETCUEBANNER, WPARAM(fDrawFocused), LPARAM(lpcwText) ) );
end;

{ TAeroSearchBox }

Constructor TAeroSearchBox.Create(AOwner: TComponent);
begin
  Inherited Create(AOwner);
  StateID:= 1;
  EditControl:= TEdit.Create(Self);
  with EditControl do
  begin
    Name:= 'Edit';
    Parent:= Self;
    AlignWithMargins:= True;
    Margins.SetBounds(2,5,3,3);
    Align:= alClient;
    BorderStyle:= bsNone;
    Text:= '';
  end;
//
  EditControlWindowProc:= EditControl.WindowProc;
  EditControl.WindowProc:= EditWindowProc;
//
  Height:= 24;
  Width:= 240;
  Constraints.MaxHeight:= 24;
  Constraints.MinHeight:= 24;
  DesigningRect:= False;
  fBannerText:= '';
end;

Destructor TAeroSearchBox.Destroy;
begin
  EditControl.WindowProc:= EditControlWindowProc;
  EditControl.Free;
  Inherited Destroy;
end;

function TAeroSearchBox.EditHandle: THandle;
begin
  Result:= EditControl.Handle;
end;

procedure TAeroSearchBox.EditWindowProc(var Message: TMessage);
var
  WinHandle: HWND;
begin
  EditControlWindowProc(Message);
  case Message.Msg of
    CM_ENTER:
    begin
      StateID:= 4;
      Invalidate;
    end;
    CM_EXIT:
    begin
      WinHandle:= WindowFromPoint(Mouse.CursorPos);
      if (WinHandle = EditControl.Handle) or (WinHandle = Self.Handle) then
        StateID:= 2
      else
        StateID:= 1;
      Invalidate;
    end;
  end;
end;

procedure TAeroSearchBox.FixGlassPaint;
begin
  EditControl.ControlState:= EditControl.ControlState-[csGlassPaint];
end;

function TAeroSearchBox.GetThemeClassName: PWideChar;
begin
  if TAeroWindow.RunWindowsVista then
  begin
    if IsCompositionActive then
      Result:= 'SearchBoxComposited::SearchBox'
    else
      Result:= 'SearchBox';
  end
  else
    Result:= 'Edit';
end;

function TAeroSearchBox.GetEditChangeEvent: TNotifyEvent;
begin
  if Assigned(EditControl) then
    Result:= EditControl.OnChange
  else
    Result:= nil;
end;

function TAeroSearchBox.GetEditControl: TEdit;
begin
  Result:= EditControl;
end;

function TAeroSearchBox.GetEditKeyDownEvent: TKeyEvent;
begin
  if Assigned(EditControl) then
    Result:= EditControl.OnKeyDown
  else
    Result:= nil;
end;

function TAeroSearchBox.GetEditKeyPressEvent: TKeyPressEvent;
begin
  if Assigned(EditControl) then
    Result:= EditControl.OnKeyPress
  else
    Result:= nil;
end;

function TAeroSearchBox.GetEditKeyUpEvent: TKeyEvent;
begin
  if Assigned(EditControl) then
    Result:= EditControl.OnKeyUp
  else
    Result:= nil;
end;

function TAeroSearchBox.GetEditTest: String;
begin
  if Assigned(EditControl) then
    Result:= EditControl.Text
  else
    Result:= '';
end;

function TAeroSearchBox.GetRenderState: TRenderConfig;
begin
  Result:= [];
end;

procedure TAeroSearchBox.SetBannerText(const Value: String);
begin
  fBannerText:= Value;
  Edit_SetCueBannerTextFocused(EditControl.Handle,PChar(fBannerText),True);
end;

procedure TAeroSearchBox.SetEditChangeEvent(const Value: TNotifyEvent);
begin
  if Assigned(EditControl) then
    EditControl.OnChange:= Value;
end;

procedure TAeroSearchBox.SetEditKeyDownEvent(const Value: TKeyEvent);
begin
  if Assigned(EditControl) then
    EditControl.OnKeyDown:= Value;
end;

procedure TAeroSearchBox.SetEditKeyPressEvent(const Value: TKeyPressEvent);
begin
  if Assigned(EditControl) then
    EditControl.OnKeyPress:= Value;
end;

procedure TAeroSearchBox.SetEditKeyUpEvent(const Value: TKeyEvent);
begin
  if Assigned(EditControl) then
    EditControl.OnKeyUp:= Value;
end;

procedure TAeroSearchBox.SetEditText(const Value: String);
begin
  if Assigned(EditControl) then
    EditControl.Text:= Value;
end;

procedure TAeroSearchBox.SetEditTheme;
begin
  if TAeroWindow.RunWindowsVista and (Parent <> nil) then
  begin
    if IsCompositionActive then
      SetWindowTheme(EditControl.Handle,'SearchBoxEditComposited',nil)
    else
      SetWindowTheme(EditControl.Handle,'SearchBoxEdit',nil)
  end;
end;

procedure TAeroSearchBox.SetEnabled(Value: Boolean);
var
  WinHandle: HWND;
begin
  Inherited SetEnabled(Value);
  EditControl.Enabled:= Value;
  if Value then
  begin
    if EditControl.Focused then
      StateID:= 3
    else
    begin
      WinHandle:= WindowFromPoint(Mouse.CursorPos);
      if (WinHandle = EditControl.Handle) or (WinHandle = Self.Handle) then
        StateID:= 2
      else
        StateID:= 1;
    end;
  end
  else
    StateID:= 3;
  Invalidate;
end;

procedure TAeroSearchBox.SetParent(AParent: TWinControl);
begin
  Inherited SetParent(AParent);
  SetEditTheme;
end;

procedure TAeroSearchBox.WndProc(var Message: TMessage);
begin
  Inherited WndProc(Message);
  case Message.Msg of
    CM_MOUSEENTER:
    begin
      if EditControl.Focused then
        StateID:= 4
      else
        StateID:= 2;
      Invalidate;
    end;
    CM_MOUSELEAVE:
    begin
      if EditControl.Focused then
        StateID:= 4
      else
        StateID:= 1;
      Invalidate;
    end;
  end;
end;

procedure TAeroSearchBox.ThemedRender(const PaintDC: hDC; const Surface: TGPGraphics; var RConfig: TRenderConfig);
var
  clRect: TRect;
  StateXP: Integer;
begin
  FixGlassPaint;
  clRect:= GetClientRect;
  if TAeroWindow.RunWindowsVista then
    DrawThemeBackground(ThemeData,PaintDC,1,StateID,clRect,@clRect)
  else
  begin
    if StateID = 3 then
      StateXP:= 4
    else
      StateXP:= 1;
    DrawThemeBackground(ThemeData,PaintDC,1,StateXP,clRect,@clRect);
  end;
end;

procedure TAeroSearchBox.ClassicRender(const ACanvas: TCanvas);
begin
  ACanvas.Brush.Color:= clWindow;
  case StateID of
    1: ACanvas.Pen.Color:= clWindowFrame;
    2: ACanvas.Pen.Color:= clHighlight;
    3: ACanvas.Pen.Color:= clInActiveBorder;
    4: ACanvas.Pen.Color:= clActiveBorder;
  end;
  ACanvas.Rectangle(1,1,Width,Height);
end;

end.
