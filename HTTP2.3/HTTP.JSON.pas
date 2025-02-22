unit HTTP.JSON;

interface

uses
  System.SysUtils,
  System.Classes,
  System.JSON,
  Data.DB;

type

{ TDatasetHelper }

  TDatasetHelper = class helper for TDataset
  strict private
    function GetFieldName(const AField: TField): String;
    function FieldToJSON(const AField: TField): TJSonValue;
    procedure InternalRecordToJSON(const AJSon: TJSonObject);
  public
    function RecordToJSON: String;
    function ToJSON: String;
  end;

implementation

{ TDatasetHelper }

function TDatasetHelper.FieldToJSON(const AField: TField): TJsonValue;
begin
  case AField.DataType of
    ftString,
    ftMemo,
    ftFmtMemo,
    ftFixedChar,
    ftWideString,
    ftFixedWideChar,
    ftWideMemo:
      Result := TJSONString.Create(AField.AsString);

    ftSmallint,
    ftInteger:
      Result := TJSONNumber.Create(AField.AsInteger);

    ftLargeint:
      Result := TJSONNumber.Create(AField.AsLargeInt);

    ftFloat,
    ftCurrency,
    ftShortint,
    ftSingle:
      Result := TJSONNumber.Create(AField.AsFloat);

    ftDate,
    ftTime,
    ftDateTime:
      Result := TJSONString.Create(FormatDateTime('yyyymmdd', AField.AsDateTime));

    ftByte: // Aggiunto il caso ftByte per gestire TINYINT come Byte
      Result := TJSONNumber.Create(AField.AsInteger);

    else
      raise Exception.Create('Tipo di campo non gestito');
  end;
end;

function TDatasetHelper.GetFieldName(const AField: TField): String;
var
  LResult: String;
begin
  LResult := AField.FieldName;
  if LResult.Length < 3 then
    result := LResult.ToLower
  else
    result := LResult.Substring(0, 1).ToLower + LResult.Substring(1);
end;

procedure TDatasetHelper.InternalRecordToJSON(const AJSon: TJSonObject);
var
  LField: TField;
begin
  for LField in Self.Fields do
    AJSon.AddPair(GetFieldName(LField), FieldToJSON(LField));
end;

function TDatasetHelper.RecordToJSON: String;
var
  LResult: TJSonObject;
begin
  LResult := TJSonObject.Create;
  try
    InternalRecordToJSON(LResult);
    result := LResult.ToJSON();
  finally
    LResult.Free;
  end;
end;

function TDatasetHelper.ToJSON: String;
var
  LResult: TJSonArray;
  LJSon: TJSonObject;
begin
  LResult := TJSonArray.Create;
  try
    Self.First;
    while not Self.Eof do
    begin
      LJSon := TJSonObject.Create;
      try
        InternalRecordToJSON(LJSon);
        LResult.Add(LJSon);
      except
        LJSon.Free;
        raise;
      end;

      Self.Next;
    end;
    result := LResult.ToJSON();
  finally
    LResult.Free;
  end;
end;

end.
