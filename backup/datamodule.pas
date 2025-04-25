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
  private

  public
    function getSequence(const pNomeSequence: string): string;
  end;

var
  DataModuleF: TDataModuleF;


implementation

{$R *.lfm}

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

