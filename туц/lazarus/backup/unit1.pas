unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  Buttons, mainf;

type

  { Tmain }

  Tmain = class(TForm)
    Inside: TBitBtn;
    Schoolpic: TImage;
    Timer1: TTimer;
    procedure InsideClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  main: Tmain;

implementation

{$R *.lfm}

{ Tmain }

procedure Tmain.Timer1Timer(Sender: TObject);
begin
  // запускаем формочку раскрываться по таймеру, сделали простейшую анимацию
  if main.width < Schoolpic.Width then
     begin
       main.Width:=main.Width+7;
       main.Height:=main.Height+7;
     end
  else
    timer1.Enabled:=false;
end;

procedure Tmain.InsideClick(Sender: TObject);
begin
  f1.Show;
end;

end.

