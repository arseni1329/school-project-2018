program project1;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, mainf, Unit2, Unit3, Unit1
  { you can add units after this };

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Initialize;
  Application.CreateForm(Tmain, main);
  Application.CreateForm(Tf1, f1);
  Application.CreateForm(Tf2, f2);
  Application.CreateForm(Tf3, f3);
  Application.Run;
end.

