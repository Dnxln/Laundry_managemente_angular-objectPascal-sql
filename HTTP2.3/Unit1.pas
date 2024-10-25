unit Unit1;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  IdCustomHTTPServer,

  HTTP.Handler,
  HTTP.Controllers;

type
  TForm1 = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  strict private
    FHandler: THTTPHandler;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  FHandler := THTTPHandler.Create;

  FHandler.RegisterController<THTTPHelloGetController>(hcGET, '/hello');
  FHandler.RegisterController<THTTPHelloPostController>(hcPOST, '/hello');

  FHandler.RegisterController<THTTPGetCapiController>(hcGET, '/capi');
  FHandler.RegisterController<THTTPPostCapoController>(hcPOST, '/capi');
  FHandler.RegisterController<THTTPPutCapoController>(hcPUT, '/capi');
  FHandler.RegisterController<THTTPDeleteCapoController>(hcDELETE, '/capi');

  FHandler.RegisterController<THTTPGetLavorazioniController>(hcGET, '/lavorazioni');
  FHandler.RegisterController<THTTPPostLavorazioneController>(hcPOST, '/lavorazioni');
  FHandler.RegisterController<THTTPPutlavorazioneController>(hcPUT, '/lavorazioni');
  FHandler.RegisterController<THTTPDeleteLavorazioneController>(hcDELETE, '/lavorazioni');

  FHandler.RegisterController<THTTPGetClientiController>(hcGET, '/clienti');
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  FHandler.Free;
end;

end.

