unit DataModule;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, ZConnection, ZStoredProcedure, ZDataset, CadastroCategoria;

type

  { TDataModuleF }

  TDataModuleF = class(TDataModule)
    ZConnection1: TZConnection;
    ZGenerica1: TZQuery;
    procedure DataModuleCreate(Sender: TObject);
  private

  public
    function getSequence(const pNomeSequence: string): string;
  end;

var
  DataModuleF: TDataModuleF;


implementation

{$R *.lfm}

procedure TDataModuleF.DataModuleCreate(Sender: TObject);
begin
  ZConnection1.HostName := 'localhost';
  ZConnection1.DataBase := 'postgres';
  ZConnection1.User     := 'postgres';
  ZConnection1.Password := '12345';
  ZConnection1.Port     := 5432;
  ZConnection1.Protocol := 'postgresql';
  ZConnection1.Connected := True;
end;

function TDataModuleF.getSequence(const pNomeSequence: string): string;
begin
  Result := '';
  try
    ZGenerica1.Close;
    ZGenerica1.SQL.Clear;
    ZGenerica1.SQL.Add('SELECT NEXTVAL(' + QuotedStr(pNomeSequence) + ') AS CODIGO');
    ZGenerica1.Open;
    Result := ZGenerica1.FieldByName('CODIGO').AsString;
  finally
    ZGenerica1.Close;
  end;
end;

end.

