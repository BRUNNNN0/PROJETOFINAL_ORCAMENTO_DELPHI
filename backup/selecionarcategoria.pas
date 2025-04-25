unit SelecionarCategoria;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Buttons, ZDataset,
  ZAbstractRODataset, Selecionar, DB;

type

  { TSelecionarCategoriaF }

  TSelecionarCategoriaF = class(TSelecionarF)
    BtnCancelar: TBitBtn;
    DataSource1: TDataSource;
    TabelaCategoria: TZQuery;
    TabelaCategoriacategoriaprodutoid: TZIntegerField;
    TabelaCategoriads_categoria_produto: TZRawStringField;
    procedure BtnCancelarClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private

  public

  end;

var
  SelecionarCategoriaF: TSelecionarCategoriaF;

implementation

{$R *.lfm}

uses
  CadastroProduto;
  { TSelecionarCategoriaF }

procedure TSelecionarCategoriaF.DBGrid1DblClick(Sender: TObject);
begin
  CadastroProdutoF.DBeditCategoriaID.Text :=
    TabelaCategoria.FieldByName('categoriaprodutoid').AsString;
  ;

  SelecionarCategoriaF.Close;
end;

procedure TSelecionarCategoriaF.BtnCancelarClick(Sender: TObject);
begin
  SelecionarCategoriaF.Close;
end;

procedure TSelecionarCategoriaF.SpeedButton1Click(Sender: TObject);
begin
  TabelaCategoria.Close;
  if EditPesquisarSC.Text <> '' then
    TabelaCategoria.SQL.Text :=
      'select * from categoria_produto where categoriaprodutoid =' + EditPesquisarSC.Text
  else
    TabelaCategoria.SQL.Text := 'select * from categoria_produto';
  TabelaCategoria.Open;
end;

end.

