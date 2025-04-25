unit relatorioDetalhadoorcamento;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, LR_DBSet,
  LR_Class, ZDataset, Relatorio;

type

  { TrelatorioDetalhadoorcamentoF }

  TrelatorioDetalhadoorcamentoF = class(TRelatorioF)
    edtOrcamentoID: TEdit;
    frDBDataSet1: TfrDBDataSet;
    frReport1: TfrReport;
    Label1: TLabel;
    qryOrcamento_item: TZQuery;
    procedure btnGerarClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  relatorioDetalhadoorcamentoF: TrelatorioDetalhadoorcamentoF;

implementation

{$R *.lfm}

{ TrelatorioDetalhadoorcamentoF }

procedure TrelatorioDetalhadoorcamentoF.btnGerarClick(Sender: TObject);
var
  OrcamentoID: Integer;
  RelatorioPath: string;
begin

  if Trim(edtOrcamentoID.Text) = '' then
  begin
    ShowMessage('Por favor, insira um ID de orçamento.');
    Exit;
  end;


  OrcamentoID := StrToIntDef(edtOrcamentoID.Text, 0);


  if OrcamentoID = 0 then
  begin
    ShowMessage('O ID do orçamento não é válido.');
    Exit;
  end;


  qryOrcamento_item.Close;
  qryOrcamento_item.SQL.Clear;
  qryOrcamento_item.SQL.Text := 'SELECT COUNT(*) FROM orcamento_item WHERE orcamentoid = :orcamentoid';
  qryOrcamento_item.ParamByName('orcamentoid').AsInteger := OrcamentoID;
  qryOrcamento_item.Open;


  if qryOrcamento_item.Fields[0].AsInteger > 0 then
  begin

    qryOrcamento_item.Close;
    qryOrcamento_item.SQL.Text := 'SELECT ' +
                            'oi.orcamentoid, oi.orcamentoitemid, oi.produtodesc, oi.qt_produto, oi.vl_unitario, oi.vl_total, ' +
                            'o.clienteid, o.dt_orcamento, o.dt_validade_orcamento, o.vl_total_orcamento, c.nome_cliente ' +
                            'FROM orcamento_item oi ' +
                            'JOIN orcamento o ON oi.orcamentoid = o.orcamentoid ' +
                            'JOIN cliente c ON o.clienteid = c.clienteid ' +
                            'WHERE oi.orcamentoid = :orcamentoid ' +
                            'ORDER BY oi.orcamentoid, oi.orcamentoitemid';
    qryOrcamento_item.ParamByName('orcamentoid').AsInteger := OrcamentoID;
    qryOrcamento_item.Open;
    ShowMessage('Orçamento encontrado! Detalhes carregados.');
    RelatorioPath := ExtractFilePath(Application.ExeName) + 'RELATORIOS\RelatorioDetalhadoOrcamento.lrf';
  end
  else
  begin
    ShowMessage('Orçamento não encontrado no banco de dados.');
    edtOrcamentoID.SetFocus;
    exit;
  end;

     if FileExists(RelatorioPath) then
  begin
    frReport1.LoadFromFile(RelatorioPath);
    frReport1.PrepareReport;
    frReport1.ShowReport;
  end
     else
      ShowMessage('Relatório não encontrado: ' + RelatorioPath);

end;

procedure TrelatorioDetalhadoorcamentoF.btnSairClick(Sender: TObject);
begin
  qryOrcamento_item.close;
  inherited;
end;

procedure TrelatorioDetalhadoorcamentoF.FormCreate(Sender: TObject);
begin
  qryOrcamento_item.Active:=True;
end;

end.

