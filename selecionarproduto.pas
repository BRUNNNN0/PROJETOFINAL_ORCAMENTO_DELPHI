unit SelecionarProduto;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ZDataset,
  ZAbstractRODataset, Selecionar, DB;

type

  { TSelecionarProdutoF }

  TSelecionarProdutoF = class(TSelecionarF)
    DataSource1: TDataSource;
    TabelaProdutoSelecionar: TZQuery;
    TabelaProdutoSelecionards_produto: TZRawStringField;
    TabelaProdutoSelecionarprodutoid: TZIntegerField;
    TabelaProdutoSelecionarvl_venda_produto: TZBCDField;
    procedure DBGrid1DblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private

  public

  end;

var
  SelecionarProdutoF: TSelecionarProdutoF;

implementation

{$R *.lfm}

uses
  OrcamentoItem, FazerOrcamento;
  { TSelecionarProdutoF }

procedure TSelecionarProdutoF.DBGrid1DblClick(Sender: TObject);
begin

  TabelaProdutoSelecionar.DisableControls;
  try
    OrcamentoItemF.DBEditIDproduto.DataSource := nil;
    OrcamentoItemF.DBEditNMproduto.DataSource := nil;
    OrcamentoItemF.DBEditVlunit.DataSource := nil;

  OrcamentoItemF.DBEditIDproduto.Text :=
    TabelaProdutoSelecionar.FieldByName('produtoid').AsString;

  OrcamentoItemF.DBEditNMproduto.Text :=
    TabelaProdutoSelecionar.FieldByName('ds_produto').AsString;

  OrcamentoItemF.DBEditVlunit.Text :=
     TabelaProdutoSelecionar.FieldByName('vl_venda_produto').AsString;


  FazerOrcamentoF.TabelaOrcamentoItemprodutoid.AsString :=
    TabelaProdutoSelecionar.FieldByName('produtoid').AsString;

  FazerOrcamentoF.TabelaOrcamentoItemprodutodesc.AsString :=
    TabelaProdutoSelecionar.FieldByName('ds_produto').AsString;

  FazerOrcamentoF.TabelaOrcamentoItemvl_unitario.AsString :=
    TabelaProdutoSelecionar.FieldByName('vl_venda_produto').AsString;

  OrcamentoItemF.EditIdproduto.Text:='';

  finally
    TabelaProdutoSelecionar.EnableControls;
  end;

  SelecionarProdutoF.Close;
end;

procedure TSelecionarProdutoF.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  CloseAction := caFree;
end;

procedure TSelecionarProdutoF.FormCreate(Sender: TObject);
begin
  TabelaProdutoSelecionar.Active:=true;
end;

procedure TSelecionarProdutoF.SpeedButton1Click(Sender: TObject);
begin

  TabelaProdutoSelecionar.Close;

  if EditPesquisarSC.Text <> '' then
  begin
    TabelaProdutoSelecionar.SQL.Text :=
      'SELECT * FROM produto WHERE status_produto = ''ATIVO'' AND produtoid = ' + EditPesquisarSC.Text;
  end
  else
  begin
    TabelaProdutoSelecionar.SQL.Text := 'SELECT * FROM produto WHERE status_produto = ''ATIVO''';
  end;

  TabelaProdutoSelecionar.Open;

  if TabelaProdutoSelecionar.IsEmpty then
  begin
    ShowMessage('Produto não está ativo ou não existe!');
  end;;

end;

end.

