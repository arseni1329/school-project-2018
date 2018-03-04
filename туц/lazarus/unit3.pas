unit Unit3;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Buttons;

type

  { Tf3 }

  Tf3 = class(TForm)
    Clform: TBitBtn;
    nextstep: TBitBtn;
    vopros: TLabel;
    vash: TLabel;
    verno: TLabel;
    L4: TLabel;
    L5: TLabel;
    procedure ClformClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure nextstepClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;
MassivStrok = array[0..10] of array[0..50] of string;

procedure mistakesinfo(str2:massivstrok);
function CloseProgram:boolean;
var
  f3: Tf3;
  otveti,correct,oshibki:array[0..50] of integer;
  step:integer;
  str: MassivStrok;
  KolOsh:integer;

implementation

{$R *.lfm}
function CloseProgram:boolean;
begin
  If MessageDlg('Выход','Вы действительно хотите выйти из программы?',
    mtConfirmation,mbYesNo,1)=mryes then
  result:= true
  else
    result:= false;
end;

procedure mistakesinfo(str2:massivstrok);
var
  str1:string;
  i,j,k,h,p:integer;
begin
 k:=0;
 h:=0;
 p:=0;
 for i:=0 to 50  do
 begin
   otveti[i]:=-1;
   correct[i]:=-1;
   oshibki[i]:=-1;
 end;
 for i:=0 to 50  do
   for j:=1 to 10 do
       begin
         str1:=str2[j,i];
         if str1<>'' then
       begin
       if (str1[1]='#') and (str1[2]<>'%') then
         begin
           oshibki[k]:=i;
           k:=k+1;
           otveti[h]:=j;
           h:=h+1;
         end
         else
         begin
           correct[p]:=j;
           p:=p+1;
         end
       end;
     end;
if oshibki[0]<>-1 then
begin
 i:=oshibki[0];
 j:=otveti[0];
 f3.vopros.caption:=str2[0,i];
 str1:=str2[j,i];
 f3.vash.caption:=copy(str1,2,length(str1));
 j:=correct[0];
 str1:=str2[j,i];
 f3.verno.caption:=copy(str1,2,length(str1));
 step:=0;
 KolOsh:=k;
end
else
begin
  f3.vopros.Caption:='';
  f3.L4.caption:='Вы не бырали ни одного ответа!';
  f3.verno.Caption:='';
  f3.L5.Caption:='';
  f3.vash.Caption:='';
  step:=p-1;
  KolOsh:=p;
end;
 str:=str2;
end;

{ Tf3 }

procedure Tf3.nextstepClick(Sender: TObject);
var
   i,j:integer;
   str1:string;
begin
   step:=step+1;
   if oshibki[step]<>-1 then
   begin
    i:=oshibki[step];
    j:=otveti[step];
    f3.vopros.caption:=str[0,i];
    str1:=str[j,i];
    f3.vash.caption:=copy(str1,2,length(str1));
    j:=correct[step];
    str1:=str[j,i];
   f3.verno.caption:=copy(str1,2,length(str1));
  end;
  if KolOsh=step then
     F3.Hide;
end;

procedure Tf3.ClformClick(Sender: TObject);
begin
  Close;
end;

procedure Tf3.FormCloseQuery(Sender: TObject; var CanClose: boolean);
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

