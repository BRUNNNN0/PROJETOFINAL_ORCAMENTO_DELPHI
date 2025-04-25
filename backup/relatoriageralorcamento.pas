unit RelatoriaGeralOrcamento;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ZDataset, LR_Class,
  LR_DBSet, Relatorio;

type

  { TRelatoriaGeralOrcamentoF }

  TRelatoriaGeralOrcamentoF = class(TRelatorioF)
    frDBDataSet1: TfrDBDataSet;
    frReport1: TfrReport;
    qryOrcamento: TZQuery;
    procedure btnGerarClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
  private

  public

  end;

var
  RelatoriaGeralOrcamentoF: TRelatoriaGeralOrcamentoF;

implementation

{$R *.lfm}

{ TRelatoriaGeralOrcamentoF }

procedure TRelatoriaGeralOrcamentoF.btnSairClick(Sender: TObject);
begin
  qryOrcamento.Close;
  inherited;
end;

procedure TRelatoriaGeralOrcamentoF.btnGerarClick(Sender: TObject);
var
  RelatorioPath: string;
begin
  // Caminho do relatório
  RelatorioPath := ExtractFilePath(Application.ExeName) + 'RELATORIOS\RelatorioGeralOrcamento.lrf';

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

end.

