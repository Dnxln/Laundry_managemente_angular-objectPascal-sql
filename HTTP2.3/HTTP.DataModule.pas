unit HTTP.DataModule;

interface

uses
  System.SysUtils, System.Classes, FireDAC.UI.Intf, FireDAC.ConsoleUI.Wait,
  FireDAC.Phys.MSSQLDef, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MSSQL, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FireDAC.Phys.ODBCBase, FireDAC.Comp.UI;

type
  TMainDataModule = class(TDataModule)
    WaitCursor: TFDGUIxWaitCursor;
    MSSQLDriverLink: TFDPhysMSSQLDriverLink;
    FDConnection: TFDConnection;
    CapiQuery: TFDQuery;
    CapoQuery: TFDQuery;
    LavorazioniQuery: TFDQuery;
    LavorazioneQuery: TFDQuery;
    ClientiQuery: TFDQuery;
    ClienteQuery: TFDQuery;
    CapoInsertQuery: TFDQuery;
    CapoUpdateQuery: TFDQuery;
    CapoDeleteQuery: TFDQuery;
    LavorazioneInsertQuery: TFDQuery;
    LavorazioneUpdateQuery: TFDQuery;
    LavorazioneDeleteQuery: TFDQuery;
    ClienteInsertQuery: TFDQuery;
    ClienteUpdateQuery: TFDQuery;
    ClienteDeleteQuery: TFDQuery;
    procedure DataModuleCreate(Sender: TObject);

  strict private
    function GetCapi: TDataset;
    function GetCapo(const AID: Integer): TDataset;

    function GetLavorazioni: TDataset;
    function GetLavorazione(const AID: Integer): TDataset;

    function GetClienti: TDataset;
    function GetCliente(const AID: Integer): TDataset;

  public
    procedure InsertCapo(const ADescrizione: String);
    procedure UpdateCapo(
      const AID: Integer; const ADescrizione: String; const AVersionID: Integer);
    procedure DeleteCapo(const AID: Integer; const AVersionID: Integer);

    procedure InsertLavorazione(const ADescrizione: String);
    procedure UpdateLavorazione(
      const AID: Integer; const ADescrizione: String; const AVersionID: Integer);
    procedure DeleteLavorazione(const AID: Integer; const AVersionID: Integer);

    property Capi: TDataset read GetCapi;
    property Capo[const AID: Integer]: TDataset read GetCapo;

    property Lavorazioni: TDataset read GetLavorazioni;
    property Lavorazione[const AID: Integer]: TDataset read GetLavorazione;

    property Clienti: TDataset read GetClienti;
    property Cliente[const AID: Integer]: TDataset read GetCliente;

  end;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

procedure TMainDataModule.DataModuleCreate(Sender: TObject);
begin
  FDConnection.Open;
end;


function TMainDataModule.GetCapi: TDataset;
begin
  result := CapiQuery;
  result.Open;
end;
function TMainDataModule.GetCapo(const AID: Integer): TDataset;
begin
  CapoQuery.ParamByName('ID').AsInteger := AID;
  result := CapoQuery;
  result.Open;
end;

procedure TMainDataModule.InsertCapo(const ADescrizione: String);
begin
  FDConnection.StartTransaction;
  try
    CapoInsertQuery.ParamByName('DESCRIZIONE').AsString	:= ADescrizione;
    CapoInsertQuery.ExecSQL;
    if CapoInsertQuery.RowsAffected <> 1 then
      raise Exception.Create('Il numero di record modificati è errato');
    FDConnection.Commit;
  except
    FDConnection.Rollback;
    raise;
  end;
end;

procedure TMainDataModule.UpdateCapo(
  const AID: Integer; const ADescrizione: String; const AVersionID: Integer);
begin
  FDConnection.StartTransaction;
  try
    CapoUpdateQuery.ParamByName('ID').AsInteger	:= AID;
    CapoUpdateQuery.ParamByName('DESCRIZIONE').AsString	:= ADescrizione;
    CapoUpdateQuery.ParamByName('VERSIONID').AsInteger	:= AVersionID;
    CapoUpdateQuery.ExecSQL;
    if CapoUpdateQuery.RowsAffected <> 1 then
      raise Exception.Create('Il numero di record modificati è errato');
    FDConnection.Commit;
  except
    FDConnection.Rollback;
    raise;
  end;
end;

procedure TMainDataModule.DeleteCapo(const AID: Integer; const AVersionID: Integer);
begin
  FDConnection.StartTransaction;
  try
    CapoDeleteQuery.ParamByName('ID').AsInteger	:= AID;
    CapoDeleteQuery.ParamByName('VERSIONID').AsInteger	:= AVersionID;
    CapoDeleteQuery.ExecSQL;
    if CapoDeleteQuery.RowsAffected <> 1 then
      raise Exception.Create('Il numero di record modificati è errato');
    FDConnection.Commit;
  except
    FDConnection.Rollback;
    raise;
  end;
end;

function TMainDataModule.GetLavorazioni: TDataset;
begin
  result := LavorazioniQuery;
  result.Open;
end;

function TMainDataModule.GetLavorazione(const AID: Integer): TDataset;
begin
  LavorazioneQuery.ParamByName('ID').AsInteger := AID;
  result := LavorazioneQuery;
  result.Open;
end;

procedure TMainDataModule.InsertLavorazione(const ADescrizione: String);
begin
  FDConnection.StartTransaction;
  try
    LavorazioneInsertQuery.ParamByName('DESCRIZIONE').AsString := ADescrizione;
    LavorazioneInsertQuery.ExecSQL;
    if LavorazioneInsertQuery.RowsAffected <> 1 then
      raise Exception.Create('Il numero di record modificati è errato');
    FDConnection.Commit;
  except
    FDConnection.Rollback;
    raise;
  end;
end;

procedure TMainDataModule.UpdateLavorazione(
  const AID: Integer; const ADescrizione: String; const AVersionID: Integer);
begin
  FDConnection.StartTransaction;
  try
    LavorazioneUpdateQuery.ParamByName('ID').AsInteger	:= AID;
    LavorazioneUpdateQuery.ParamByName('DESCRIZIONE').AsString	:= ADescrizione;
    LavorazioneUpdateQuery.ParamByName('VERSIONID').AsInteger	:= AVersionID;
    LavorazioneUpdateQuery.ExecSQL;
    if LavorazioneUpdateQuery.RowsAffected <> 1 then
      raise Exception.Create('Il numero di record modificati è errato');
    FDConnection.Commit;
  except
    FDConnection.Rollback;
    raise;
  end;
end;

procedure TMainDataModule.DeleteLavorazione(
  const AID: Integer; const AVersionID: Integer);
begin
  FDConnection.StartTransaction;
  try
    LavorazioneDeleteQuery.ParamByName('ID').AsInteger	:= AID;
    LavorazioneDeleteQuery.ParamByName('VERSIONID').AsInteger	:= AVersionID;
    LavorazioneDeleteQuery.ExecSQL;
    if LavorazioneDeleteQuery.RowsAffected <> 1 then
      raise Exception.Create('Il numero di record modificati è errato');
    FDConnection.Commit;
  except
    FDConnection.Rollback;
    raise;
  end;
end;

function TMainDataModule.GetClienti: TDataset;
begin
  result := ClientiQuery;
  result.Open;
end;

function TMainDataModule.GetCliente(const AID: Integer): TDataset;
begin
  ClienteQuery.ParamByName('ID').AsInteger := AID;
  result := ClienteQuery;
  result.Open;
end;

end.
