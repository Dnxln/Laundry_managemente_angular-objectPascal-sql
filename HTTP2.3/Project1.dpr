program Project1;

uses
  Vcl.Forms,
  Unit1 in 'Unit1.pas' {Form1},
  Vcl.Themes,
  Vcl.Styles,
  HTTP.Controller in 'HTTP.Controller.pas',
  HTTP.Handler in 'HTTP.Handler.pas',
  HTTP.Controllers in 'HTTP.Controllers.pas',
  HTTP.DataModule in 'HTTP.DataModule.pas' {MainDataModule: TDataModule},
  HTTP.JSON in 'HTTP.JSON.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
