unit HTTP.Controller;

interface

uses
  System.SysUtils,
  System.Classes,
  IdCustomHTTPServer;

type

{ THTTPAbstractController }

  THTTPAbstractController = class abstract
  strict protected
    FRequest: TIdHTTPRequestInfo;
    FResponse: TIdHTTPResponseInfo;

    function GetBody: String;
  public
    constructor Create(
      const ARequest: TIdHTTPRequestInfo;
      const AResponse: TIdHTTPResponseInfo); virtual;

    procedure AfterConstruction; override;

    procedure Execute; virtual; abstract;

    property Body: String read GetBody;
  end;

  THTTPControllerClass = class of THTTPAbstractController;

implementation

{ THTTPAbstractController }

constructor THTTPAbstractController.Create(
  const ARequest: TIdHTTPRequestInfo; const AResponse: TIdHTTPResponseInfo);
begin
  inherited Create;
  FRequest := ARequest;
  FResponse := AResponse;
end;

procedure THTTPAbstractController.AfterConstruction;
begin
  inherited AfterConstruction;
  FResponse.ResponseNo := 201;
  FResponse.ContentType := 'application/json'
end;

function THTTPAbstractController.GetBody: String;
var
  LPosition: Int64;
  LBytes: TBytes;
begin
  result := string.Empty;
  if Assigned(FRequest.PostStream) then
  begin
    LPosition := FRequest.PostStream.Position;
    FRequest.PostStream.Position := 0;
    try
      SetLength(LBytes, FRequest.PostStream.Size);
      FRequest.PostStream.Read(LBytes, 0, Length(LBytes));
    finally
      FRequest.PostStream.Position := LPosition;
    end;
    result := TEncoding.UTF8.GetString(LBytes);
  end;
end;

end.
