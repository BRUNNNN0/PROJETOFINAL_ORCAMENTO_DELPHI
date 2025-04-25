unit RelatoriadeProdutos;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, LR_Class, LR_DBSet,
  ZDataset, Relatorio;

type

  { TRelatoriadeProdutosF }

  TRelatoriadeProdutosF = class(TRelatorioF)
    frDBDataSet1: TfrDBDataSet;
    frReport1: TfrReport;
    qryProdutos: TZQuery;
    procedure btnGerarClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  RelatoriadeProdutosF: TRelatoriadeProdutosF;

implementation

{$R *.lfm}

{ TRelatoriadeProdutosF }

procedure TRelatoriadeProdutosF.btnGerarClick(Sender: TObject);
  var
    RelatorioPath: string;
  begin
    // Caminho do relatório
    RelatorioPath := ExtractFilePath(Application.ExeName) + 'RELATORIOS\RelatorioProduto.lrf';

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

procedure TRelatoriadeProdutosF.btnSairClick(Sender: TObject);
begin
  qryProdutos.Close;
  inherited;
end;

procedure TRelatoriadeProdutosF.FormCreate(Sender: TObject);
begin
  qryProdutos.Active:=True;
end;

end.

