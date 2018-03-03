unit Unit2;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Buttons,Unit3;

type

  { Tf2 }

  Tf2 = class(TForm)
    showmistakes: TBitBtn;
    correct: TLabel;
    Label1: TLabel;
    percent: TLabel;
    incorrect: TLabel;
    total: TLabel;
    procedure showmistakesClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;


MassivStrok = array[0..10] of array[0..50] of string;
procedure peredacha(i:integer; str2:massivStrok; flag:integer);
var
  f2: Tf2;
 str:massivStrok;

implementation

{$R *.lfm}

{ Tf2 }

procedure peredacha(i: integer; Str2:MassivStrok; flag:integer);
var
  q,j:integer;
    str1:string;
begin
  q:=0;
  for i:=0 to 50 do
   for j:=1 to 10 do
    begin
      str1:=str2[j,i];
      if str1<>'' then
      if (str1[1]='#') and (str1[2]='%') then
        q:=q+1;
    end;
 f2.percent.caption:=inttostr(round(q/flag*100))+'% правльных ответов';
 f2.incorrect.caption:=inttostr(flag-q)+' ошибки(ок)';
 f2.total.caption:=inttostr(flag)+' вопроса(ов) пройдено';
 f2.correct.Caption:=inttostr(q)+' правильных ответа(ов)';
  if q=flag then
  f2.showmistakes.enabled:=false;
  str:=str2;
end;

procedure Tf2.showmistakesClick(Sender: TObject);
begin
 mistakesinfo(str);
  f3.show;
end;

end.

