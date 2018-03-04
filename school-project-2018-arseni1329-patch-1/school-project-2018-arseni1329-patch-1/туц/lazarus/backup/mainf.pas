unit mainf;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ComCtrls, ExtCtrls, Menus, Buttons,Unit2;

type

  { Tf1 }

  Tf1 = class(TForm)
    back: TBitBtn;
    Lprogress: TLabel;
    save: TBitBtn;
    forward: TBitBtn;
    od1: TOpenDialog;
    Progress: TProgressBar;
    questions: TRadioGroup;
    procedure backClick(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure forwardClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure QuestionsClick(Sender: TObject);
    procedure saveClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

MassivStrok = array[0..10] of array[0..50] of string;
procedure cleanRad;
procedure vopros(i: integer; Str2: MassivStrok);

var
  f1: Tf1;
  Str2: MassivStrok;
  i,flag:integer;

implementation

{$R *.lfm}

{ Tf1 }

procedure cleanRad;//процедура очищения radiogroup
begin
 f1.questions.ItemIndex:=-1;
 f1.questions.Items.Clear;
end;

procedure vopros(i: integer; Str2: MassivStrok);//процедура выведения вопроса
var
  j, count:integer;
  str1:string;
begin
  f1.questions.caption:=str2[0,i];
  count:=-1;
  for j:=1 to 10 do
   begin
    if str2[j,i]<>'' then
    begin
      str1:=str2[j,i];
      if (str1[1]='%') then
      begin
        str1:= copy(str1,2,length(str1));
        f1.questions.Items.Add(str1);
      end
        else
        begin
          if str1[1]='#'  then
          begin
            count:=j-1;
            if str1[2]='%' then
              str1:= copy(str1,3,length(str1))
            else
              str1:= copy(str1,2,length(str1));
            f1.questions.Items.Add(str1);
          end
          else
           f1.questions.Items.Add(str2[j,i]);
        end;
    end;
   end;
  if count>=0 then
    f1.questions.ItemIndex:=count;
  f1.progress.Width:=f1.width;
end;


procedure Tf1.QuestionsClick(Sender: TObject);//процедура запоминания отмеченного варианта ответа
  var
  j,otmetka:integer;
  str1:string;
begin
  if questions.ItemIndex>-1 then
  begin
    for j:=1 to 10 do
     begin
       str1:=str2[j,i];
       if (str1<>'') and (str1[1]='#') then
         str2[j,i]:=copy(str1,2,length(str1));
     end;
    otmetka:=questions.ItemIndex+1;
    str1:= str2[otmetka,i];
    str1:='#'+str1;
    str2[otmetka,i]:=str1;
  end;
end;


procedure Tf1.saveClick(Sender: TObject);//завершение теста
begin
  If MessageDlg('Завершить тест','Вы уверены?',
    mtConfirmation,mbYesNo,1)=mryes then
  begin
    peredacha(i,str2, flag);
    f2.Show;
    f1.close;
  end;
end;


procedure Tf1.forwardClick(Sender: TObject);//переключить на следующий вопрос
var
  proverka: integer;
begin
  cleanrad;
  i:=i+1;
  proverka:=i+1;
  if i>0 then
    f1.back.enabled:=true
  else
    f1.Back.enabled:=false;
  if proverka<flag then
    f1.forward.Enabled:=true
  else
    begin
      f1.forward.Enabled:=false;
      f1.save.visible:=true;
    end;
   f1.Progress.Max:=flag-1;
   f1.Progress.Position:=i;
  vopros(i,str2);
end;

procedure Tf1.backClick(Sender: TObject);//переключить на предыдущий вопрос
begin
  cleanrad;
  i:=i-1;
  if i>0  then
    begin
      f1.back.enabled:=true;
      f1.save.visible:=false;
    end
  else
    f1.Back.enabled:=false;
  f1.forward.Enabled:=true;
     f1.Progress.Max:=flag;
  f1.Progress.Position:=i;
  vopros(i,str2);
end;

procedure Tf1.FormHide(Sender: TObject);
var
  r, c: integer;
begin
  // очищение массива на случай, если будет повторное прохождение теста
 { for c:=0 to 50  do
   for r:=1 to 10 do
     str2[r,c]:='';
  cleanRad;}
end;

procedure Tf1.FormShow(Sender: TObject);
var
  fil:textfile;//файловая переменная
  FName, str:string;
  j:integer;
begin
flag:=0;
 If od1.Execute then
   begin
     FName:= od1.FileName;
     // привязка имени фала к файловой переменной
     assignFile(fil,FName);
     reset(fil);
     i:=0;
     while not eof(fil) do
       begin
       j:=1;
     readln(fil, str);
       while not (str[1]='$') do
       begin
         if (str[1]='?') then
           str2[0,i]:=copy(str,2,length(str))
         else
           begin
             str2[j,i]:=str;
             j:=j+1;
           end;
         if not eof(fil) then
         readln(fil, str);
        end;
       i:=i+1;
       end;
    closefile(fil);
    flag:=i;
   end
else
 begin
  showmessage ('файл не выбран');
  f1.Close;
 end;
 i:=0;
 vopros(i,str2);
end;


end.

