unit UnitMain;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls;

const
  SnowFlakeCount = 200;

type

  TSnowFlake = record
    X: Single;
    Y: Single;
    Speed: Single;
    Size: Integer;
    Time: Single;
    DeltaTime: Single;
  end;

  { TFormMain }

  TFormMain = class(TForm)
    Delay: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure TimerUpdate(Sender: TObject);
  private
    Snow: array [0..SnowFlakeCount - 1] of TSnowFlake;

    function CreateSnowFlake: TSnowFlake;
    procedure CreateSnow;
    procedure UpdateSnow;
  public

  end;

var
  FormMain: TFormMain;

implementation

uses
  Math;

{$R *.lfm}

{ TFormMain }

procedure TFormMain.FormPaint(Sender: TObject);
var
  X, Y: Integer;
  Size: Integer;
  I: Integer;
  Offset: Single;
begin
  Canvas.Brush.Color := clBlack;
  Canvas.FillRect(0, 0, ClientWidth, ClientHeight);

  Canvas.Pen.Style := psClear;
  Canvas.Brush.Color := clWhite;

  for I := 0 to High(Snow) do
  begin
    Size := Snow[I].Size;

    Offset := Sin(Snow[I].Time) * 20.0;
    X := Trunc(Snow[I].X + Offset);
    Y := Trunc(Snow[I].Y);

    Canvas.Ellipse(X, Y, X + Size, Y + Size);
  end;
end;

procedure TFormMain.FormCreate(Sender: TObject);
begin
  CreateSnow;
end;

procedure TFormMain.TimerUpdate(Sender: TObject);
begin
  UpdateSnow;
  Invalidate;
end;

function TFormMain.CreateSnowFlake: TSnowFlake;
const
  MaxSpeed = 5;
  MaxSize = 10;
  MaxDelta = 0.1;
begin
  Result.X := RandomRange(0, ClientWidth);
  Result.Y := 0;
  Result.Speed := 0.5 + Random * MaxSpeed;
  Result.Size := RandomRange(2, MaxSize);
  Result.Time := Random * 2.0 * Pi;
  Result.DeltaTime := Random * MaxDelta;
end;

procedure TFormMain.CreateSnow;
var
  I: Integer;
begin
  for I := 0 to High(Snow) do
  	  Snow[I] := CreateSnowFlake;
end;

procedure TFormMain.UpdateSnow;
var
  I: Integer;
begin
  for I := 0 to High(Snow) do
  begin
    Snow[I].Y := Snow[I].Y + Snow[I].Speed;

    Snow[I].Time := Snow[I].Time + Snow[I].DeltaTime;

    if Snow[I].Y > ClientHeight then
  	   Snow[I] := CreateSnowFlake;
  end;
end;

end.
