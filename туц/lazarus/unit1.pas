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
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
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

uses unit3;

{$R *.lfm}

{ Tmain }

procedure Tmain.Timer1Timer(Sender: TObject);
begin
  // запускаем формочку раскрываться по таймеру, сделали простейшую анимацию
  if main.width < Schoolpic.Width+3 then
     begin
       main.Width:=main.Width+7;
       main.Height:=main.Height+6;
     end
  else
    timer1.Enabled:=false;
end;

procedure Tmain.InsideClick(Sender: TObject);
begin
  main.Hide;
  f1.Show;
end;

procedure Tmain.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  if CloseProgram then
  begin
     CanClose:=true;
     Application.Terminate;
  end
  else
    CanClose:=false;
end;

end.

