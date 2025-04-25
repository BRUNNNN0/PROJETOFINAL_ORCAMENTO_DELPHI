unit RelatorioCategoria;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ZDataset, LR_Class,
  LR_DBSet, Relatorio;

type

  { TRelatorioCategoriaF }

  TRelatorioCategoriaF = class(TRelatorioF)
    frDBDataSet1: TfrDBDataSet;
    frReport1: TfrReport;
    qryCategoria: TZQuery;
    procedure btnGerarClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
  private

  public

  end;

var
  RelatorioCategoriaF: TRelatorioCategoriaF;

implementation

{$R *.lfm}

{ TRelatorioCategoriaF }

procedure TRelatorioCategoriaF.btnGerarClick(Sender: TObject);
  var
  RelatorioPath: string;
begin
  // Caminho do relatório
  RelatorioPath := ExtractFilePath(Application.ExeName) + 'RELATORIOS\RelatorioCategoria.lrf';

  // Verifica se o arquivo existe antes de carregar
  if FileExists(RelatorioPath) then
  begin
    frReport1.LoadFromFile(RelatorioPath);
    frReport1.PrepareReport;
    frReport1.ShowReport;
  end
  else
    ShowMessage('Relatório não encontrado: ' + RelatorioPath);
end;

procedure TRelatorioCategoriaF.btnSairClick(Sender: TObject);
begin
  qryCategoria.Close;
  inherited;
end;


end.

