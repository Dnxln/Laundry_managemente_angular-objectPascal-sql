object MainDataModule: TMainDataModule
  OnCreate = DataModuleCreate
  Height = 671
  Width = 1095
  object WaitCursor: TFDGUIxWaitCursor
    Provider = 'Console'
    ScreenCursor = gcrNone
    Left = 32
    Top = 20
  end
  object MSSQLDriverLink: TFDPhysMSSQLDriverLink
    ListServers = False
    Left = 120
    Top = 20
  end
  object FDConnection: TFDConnection
    Params.Strings = (
      'Database=Lavanderia2'
      'User_Name=sa'
      'Password=Sviluppo#2023'
      'Server=192.168.1.60\SQLExpress'
      'DriverID=MSSQL')
    Connected = True
    LoginPrompt = False
    Left = 220
    Top = 20
  end
  object CapiQuery: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'SELECT ID, Descrizione, VersionID'
      'FROM Capi'
      'ORDER BY ID')
    Left = 51
    Top = 94
  end
  object CapoQuery: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'SELECT ID, Descrizione, VersionID'
      'FROM Capi'
      'WHERE ID = :ID')
    Left = 95
    Top = 116
    ParamData = <
      item
        Name = 'ID'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object LavorazioniQuery: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'SELECT ID, Descrizione, VersionID'
      'FROM Lavorazioni'
      'ORDER BY ID')
    Left = 44
    Top = 238
  end
  object LavorazioneQuery: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'SELECT ID, Descrizione, VersionID'
      'FROM Lavorazioni'
      'WHERE ID = :ID')
    Left = 106
    Top = 260
    ParamData = <
      item
        Name = 'ID'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object ClientiQuery: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      
        'SELECT ID, Nome, Cognome, Indirizzo, Telefono, Giorno, Mese, Ver' +
        'sionID'
      'FROM Clienti'
      'ORDER BY ID')
    Left = 42
    Top = 390
  end
  object ClienteQuery: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      
        'SELECT ID, Nome, Cognome, Indirizzo, Telefono, Giorno, Mese, Ver' +
        'sionID'
      'FROM Clienti'
      'WHERE ID = :ID')
    Left = 92
    Top = 412
    ParamData = <
      item
        Name = 'ID'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object CapoInsertQuery: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'DECLARE @ID int'
      ''
      'SELECT @ID = NEXT VALUE FOR CapiID'
      ''
      'INSERT INTO Capi ('
      '  ID,'
      '  Descrizione,'
      '  VersionID)'
      'VALUES ('
      '  @ID,'
      '  :Descrizione,'
      '  0)'
      '')
    Left = 139
    Top = 138
    ParamData = <
      item
        Name = 'DESCRIZIONE'
        DataType = ftWideString
        ParamType = ptInput
        Size = 50
      end>
  end
  object CapoUpdateQuery: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'UPDATE Capi SET'
      '  Descrizione = :Descrizione,'
      '  VersionID = VersionID + 1'
      'WHERE'
      '  ID = :ID AND VersionID = :VersionID')
    Left = 201
    Top = 160
    ParamData = <
      item
        Name = 'DESCRIZIONE'
        DataType = ftWideString
        ParamType = ptInput
        Size = 50
      end
      item
        Name = 'ID'
        DataType = ftInteger
        ParamType = ptInput
      end
      item
        Name = 'VERSIONID'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object CapoDeleteQuery: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'DELETE FROM Capi'
      'WHERE'
      '  ID = :ID AND VersionID = :VersionID')
    Left = 267
    Top = 182
    ParamData = <
      item
        Name = 'ID'
        DataType = ftInteger
        ParamType = ptInput
      end
      item
        Name = 'VERSIONID'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object LavorazioneInsertQuery: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'DECLARE @ID int'
      ''
      'SELECT @ID = NEXT VALUE FOR LavorazioniID'
      ''
      'INSERT INTO Lavorazioni ('
      '  ID,'
      '  Descrizione,'
      '  VersionID)'
      'VALUES ('
      '  @ID,'
      '  :Descrizione,'
      '  0)'
      '')
    Left = 170
    Top = 282
    ParamData = <
      item
        Name = 'DESCRIZIONE'
        DataType = ftWideString
        ParamType = ptInput
        Size = 50
      end>
  end
  object LavorazioneUpdateQuery: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'UPDATE Lavorazioni SET'
      '  Descrizione = :Descrizione,'
      '  VersionID = VersionID + 1'
      'WHERE'
      '  ID = :ID AND VersionID = :VersionID')
    Left = 250
    Top = 306
    ParamData = <
      item
        Name = 'DESCRIZIONE'
        DataType = ftWideString
        ParamType = ptInput
        Size = 50
      end
      item
        Name = 'ID'
        DataType = ftInteger
        ParamType = ptInput
      end
      item
        Name = 'VERSIONID'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object LavorazioneDeleteQuery: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'DELETE FROM Lavorazioni'
      'WHERE'
      '  ID = :ID AND VersionID = :VersionID')
    Left = 330
    Top = 328
    ParamData = <
      item
        Name = 'ID'
        DataType = ftInteger
        ParamType = ptInput
      end
      item
        Name = 'VERSIONID'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object ClienteInsertQuery: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'DECLARE @ID int'
      ''
      'SELECT @ID = NEXT VALUE FOR ClientiID'
      ''
      'INSERT INTO Clienti ('
      '  ID,'
      '  Descrizione,'
      '  VersionID)'
      'VALUES ('
      '  @ID,'
      '  :Descrizione,'
      '  0)'
      '')
    Left = 168
    Top = 474
    ParamData = <
      item
        Name = 'DESCRIZIONE'
        DataType = ftWideString
        ParamType = ptInput
        Size = 50
      end>
  end
  object ClienteUpdateQuery: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'UPDATE Clienti SET'
      '  Descrizione = :Descrizione,'
      '  VersionID = VersionID + 1'
      'WHERE'
      '  ID = :ID AND VersionID = :VersionID')
    Left = 234
    Top = 496
    ParamData = <
      item
        Name = 'DESCRIZIONE'
        DataType = ftWideString
        ParamType = ptInput
        Size = 50
      end
      item
        Name = 'ID'
        DataType = ftInteger
        ParamType = ptInput
      end
      item
        Name = 'VERSIONID'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object ClienteDeleteQuery: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'DELETE FROM Clienti'
      'WHERE'
      '  ID = :ID AND VersionID = :VersionID')
    Left = 304
    Top = 518
    ParamData = <
      item
        Name = 'ID'
        DataType = ftInteger
        ParamType = ptInput
      end
      item
        Name = 'VERSIONID'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
end