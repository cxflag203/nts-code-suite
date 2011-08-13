unit NTS.Code.Components.VirtualStringList;

interface

uses
  Classes, SysUtils;

type
  TVirtualStringList = class(TComponent)
  private
    FLines: TStrings;
    fSetCount: Integer;
    function GetText: String;
    procedure SetText(const Value: String);
    procedure SetNewCount(const Value: Integer);
    procedure SetLines(const Value: TStrings);
  public
    Constructor Create(AOwner: TComponent); override;
    Destructor Destroy; override;
  published
    property SetCount: Integer Read fSetCount Write SetNewCount;
    property Lines: TStrings read FLines write SetLines;
    property Text: String Read GetText Write SetText;
  end;

implementation

{ TVirtualStringList }

Constructor TVirtualStringList.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fSetCount:= 0;
  FLines:= TStringList.Create;
end;

Destructor TVirtualStringList.Destroy;
begin
  FLines.Free;
  inherited Destroy;
end;

function TVirtualStringList.GetText: String;
begin
  Result:= FLines.Text;
end;

Procedure TVirtualStringList.SetLines(const Value: TStrings);
begin
  FLines.Assign(Value);
end;

procedure TVirtualStringList.SetNewCount(const Value: Integer);
var
  I: Integer;
begin
  fSetCount:= Value;
  if not (csDesigning in ComponentState) then
  begin
    FLines.Clear;
    for I:=0 to Value do
      FLines.Add(IntToStr(I));
  end;
end;

procedure TVirtualStringList.SetText(const Value: String);
begin
  FLines.Text:= Value;
end;

end.
