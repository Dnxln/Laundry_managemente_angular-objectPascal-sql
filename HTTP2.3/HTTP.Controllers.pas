unit HTTP.Controllers;

interface

uses
  System.SysUtils,
  System.Classes,
  System.JSON,
  IdCustomHTTPServer,
  HTTP.DataModule,
  Data.DB,
  HTTP.Controller,
  IdHTTPServer,
  HTTP.JSON;

type

  THTTPDatamoduleController = class abstract(THTTPAbstractController)
  strict protected
    FDataModule: TMainDataModule;
  public
    constructor Create(
      const ARequest: TIdHTTPRequestInfo;
      const AResponse: TIdHTTPResponseInfo); override;
    destructor Destroy; override;
  end;

  { THTTPHelloGetController }
  THTTPHelloGetController = class(THTTPAbstractController)
  public
    procedure Execute; override;
  end;

  { THTTPHelloPostController }
  THTTPHelloPostController = class(THTTPAbstractController)
  public
    procedure Execute; override;
  end;

  { THTTPGetCapiController / GetCapoID }
  THTTPGetCapiController = class(THTTPDatamoduleController)
  public
    procedure Execute; override;
  end;
  { THTTPGetLavorazioniController / GetLavorazioneID }
  THTTPGetLavorazioniController = class(THTTPDatamoduleController)
  public
    procedure Execute; override;
  end;
  { THTTPGetClientiController / GetClienteID }
  THTTPGetClientiController = class(THTTPDatamoduleController)
  public
    procedure Execute; override;
  end;


  { THTTPPostCapoController }
  THTTPPostCapoController = class(THTTPDatamoduleController)
  public
    procedure Execute; override;
  end;
  { THTTPPostLavorazioneController }
  THTTPPostLavorazioneController = class(THTTPDatamoduleController)
  public
    procedure Execute; override;
  end;


  { THTTPPutCapoController }
  THTTPPutCapoController = class(THTTPDatamoduleController)
  public
    procedure Execute; override;
  end;
  { THTTPPutlavorazioneController }
  THTTPPutlavorazioneController = class(THTTPDatamoduleController)
  public
    procedure Execute; override;
  end;

  { THTTPDeleteCapoController }
  THTTPDeleteCapoController = class(THTTPDatamoduleController)
  public
    procedure Execute; override;
  end;
  { THTTPDeleteLavorazioneController }
  THTTPDeleteLavorazioneController = class(THTTPDatamoduleController)
  public
    procedure Execute; override;
  end;



implementation

{ THTTPHelloGetController }
procedure THTTPHelloGetController.Execute;
begin
  FResponse.ContentText := 'Hello, GET request!' +
    TThread.Current.Handle.ToString + ' ' + MainThreadID.ToString;
end;
{ THTTPHelloPostController }
procedure THTTPHelloPostController.Execute;
var
  LJson: TJSONValue;
  LNome, LCognome: string;
begin
  LJson := TJSONObject.ParseJSONValue(Body, False, True);
  try
    LNome := LJson.GetValue<string>('nome', String.Empty);
    LCognome := LJson.GetValue<string>('cognome', String.Empty);

    FResponse.ContentText := Format('Hello, %s %s! POST request received.', [LNome, LCognome]);
  finally
    LJson.Free;
  end;
end;


{ THTTPDatamoduleController }
constructor THTTPDatamoduleController.Create(
  const ARequest: TIdHTTPRequestInfo; const AResponse: TIdHTTPResponseInfo);
begin
  inherited Create(ARequest, AResponse);
  FDataModule := TMainDataModule.Create(nil);

  FResponse.CustomHeaders.AddValue('Access-Control-Allow-Origin', '*');

  FResponse.ContentType := 'application/json';
  FResponse.ContentText := '{}';
end;

destructor THTTPDatamoduleController.Destroy;
begin
  FDataModule.Free;
  inherited Destroy;
end;



{ THTTPGetCapiController / GetCapoID }
procedure THTTPGetCapiController.Execute;
var
  LInput, LResult: String;
  LID: Integer;
begin
  LInput := FRequest.Params.Values['ID'];
  if LInput.IsEmpty then
    LResult := FDataModule.Capi.ToJSON
  else if Integer.TryParse(LInput, LID) then
    LResult := FDataModule.Capo[LID].ToJSON
  else
    raise Exception.Create('Parametro non valido');

  FResponse.ContentText := LResult;
end;
{ THTTPGetLavorazioniController / GetLavorazioneID }
procedure THTTPGetLavorazioniController.Execute;
var
  LInput, LResult: String;
  LID: Integer;
begin
  LInput := FRequest.Params.Values['ID'];
  if LInput.IsEmpty then
    LResult := FDataModule.Lavorazioni.ToJSON
  else if Integer.TryParse(LInput, LID) then
    LResult := FDataModule.Lavorazione[LID].ToJSON
  else
    raise Exception.Create('Parametro non valido');

  FResponse.ContentText := LResult;
end;
{ THTTPGetClientiController / GetClienteID }
procedure THTTPGetClientiController.Execute;
var
  LInput, LResult: String;
  LID: Integer;
begin
  LInput := FRequest.Params.Values['ID'];
  if LInput.IsEmpty then
    LResult := FDataModule.Clienti.ToJSON
  else if Integer.TryParse(LInput, LID) then
    LResult := FDataModule.Cliente[LID].ToJSON
  else
    raise Exception.Create('Parametro non valido');

  FResponse.ContentText := LResult;
end;


{ THTTPPostCapoController }
procedure THTTPPostCapoController.Execute;
var
  LJson: TJSONValue;
  LDescrizione: string;
begin
  LJson := TJSONObject.ParseJSONValue(Body, False, True);
  try
    LDescrizione := LJson.GetValue<string>('descrizione', '');
    try
      FDataModule.InsertCapo(LDescrizione);
      FResponse.ResponseNo := 201;
    except
      on E: Exception do
      begin
        FResponse.ContentText := '{"error": "' + E.Message + '"}';
        FResponse.ResponseNo := 500;
      end;
    end;
  finally
    LJson.Free;
  end;
end;

{ THTTPPostLavorazioneController }
procedure THTTPPostLavorazioneController.Execute;
var
  LJson: TJSONValue;
  LDescrizione: string;
begin
  LJson := TJSONObject.ParseJSONValue(Body, False, True);
  try
    LDescrizione := LJson.GetValue<string>('descrizione', '');
    try
      FDataModule.InsertLavorazione(LDescrizione);
      FResponse.ResponseNo := 201;
    except
      on E: Exception do
      begin
        FResponse.ContentText := '{"error": "' + E.Message + '"}';
        FResponse.ResponseNo := 500;
      end;
    end;
  finally
    LJson.Free;
  end;
end;

{ THTTPPutCapoController }
procedure THTTPPutCapoController.Execute;
var
  LJson: TJSONValue;
  LID, LVersionID: Integer;
  LDescrizione: string;
begin
  LJson := TJSONObject.ParseJSONValue(Body, False, True);
  try
    LID := LJson.GetValue<Integer>('id', 0);
    LVersionID := LJson.GetValue<Integer>('versionID', 0);
    LDescrizione := LJson.GetValue<string>('descrizione', '');
    try
      FDataModule.UpdateCapo(LID, LDescrizione, LVersionID);
      FResponse.ResponseNo := 200;
    except
      on E: Exception do
      begin
        FResponse.ContentText := '{"error": "' + E.Message + '"}';
        FResponse.ResponseNo := 500;
      end;
    end;
  finally
    LJson.Free;
  end;
end;

{ THTTPPutLavorazioneController }
procedure THTTPPutLavorazioneController.Execute;
var
  LJson: TJSONValue;
  LID, LVersionID: Integer;
  LDescrizione: string;
begin
  LJson := TJSONObject.ParseJSONValue(Body, False, True);
  try
    LID := LJson.GetValue<Integer>('id', 0);
    LVersionID := LJson.GetValue<Integer>('versionID', 0);
    LDescrizione := LJson.GetValue<string>('descrizione', '');
    try
      FDataModule.UpdateLavorazione(LID, LDescrizione, LVersionID);
      FResponse.ResponseNo := 200;
    except
      on E: Exception do
      begin
        FResponse.ContentText := '{"error": "' + E.Message + '"}';
        FResponse.ResponseNo := 500;
      end;
    end;
  finally
    LJson.Free;
  end;
end;

{ THTTPDeleteCapoController }
procedure THTTPDeleteCapoController.Execute;
var
  LID, LVersionID: Integer;
begin
  LID := StrToInt(FRequest.Params.Values['id']);
  LVersionID := StrToInt(FRequest.Params.Values['versionID']);
  try
    FDataModule.DeleteCapo(LID, LVersionID);
    FResponse.ResponseNo := 200;
  except
    on E: Exception do
    begin
      FResponse.ContentText := '{"error": "' + E.Message + '"}';
      FResponse.ResponseNo := 500;
    end;
  end;
end;

{ THTTPDeleteLavorazioneController }
procedure THTTPDeleteLavorazioneController.Execute;
var
  LID, LVersionID: Integer;
begin
  LID := StrToInt(FRequest.Params.Values['id']);
  LVersionID := StrToInt(FRequest.Params.Values['versionID']);
  try
    FDataModule.DeleteLavorazione(LID, LVersionID);
    FResponse.ResponseNo := 200;
  except
    on E: Exception do
    begin
      FResponse.ContentText := '{"error": "' + E.Message + '"}';
      FResponse.ResponseNo := 500;
    end;
  end;
end;

end.
