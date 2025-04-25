unit CadastroProduto;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, DBCtrls,
  MaskEdit, ZDataset, ZSqlUpdate, ZAbstractRODataset, XcadModelo,
  SelecionarCategoria, DB;

type

  { TCadastroProdutoF }

  TCadastroProdutoF = class(TXcadModeloF)
    BtnPesquisarIDcate: TButton;
    DataSource1: TDataSource;
    DBEdit6: TDBEdit;
    DBeditCategoriaID: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DBRadioGroup1: TDBRadioGroup;
    EditPesquisar: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    TabelaProduto: TZQuery;
    TabelaProdutocategoriaprodutoid: TZIntegerField;
    TabelaProdutods_produto: TZRawStringField;
    TabelaProdutodt_cadastro_produto: TZDateTimeField;
    TabelaProdutoobs_produto: TZRawStringField;
    TabelaProdutoprodutoid: TZIntegerField;
    TabelaProdutostatus_produto: TZRawStringField;
    TabelaProdutovl_venda_produto: TZBCDField;
    ZQuery1: TZQuery;
    ZUpdateSQL1: TZUpdateSQL;
    procedure BtnCancelarClick(Sender: TObject);
    procedure BtnExcluirClick(Sender: TObject);
    procedure BtnGravarClick(Sender: TObject);
    procedure BtnNovoClick(Sender: TObject);
    procedure BtnPesquisarIDcateClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure Label4Click(Sender: TObject);
    procedure MaskEdit1Change(Sender: TObject);
    procedure Panel3Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure TabelaProdutoAfterInsert(DataSet: TDataSet);
  private

  public

  end;

var
  CadastroProdutoF: TCadastroProdutoF;

    Dia, Mes, Ano, DataStr: string;
     Tam : Integer;
implementation

{$R *.lfm}
uses
  DataModule;

{ TCadastroProdutoF }


procedure TCadastroProdutoF.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  CloseAction := caFree;
end;

procedure TCadastroProdutoF.FormCreate(Sender: TObject);
begin
  TabelaProduto.Active := true;

end;

procedure TCadastroProdutoF.BtnPesquisarIDcateClick(Sender: TObject);
begin
    SelecionarCategoriaF := TSelecionarCategoriaF.Create(Self);
  try
    SelecionarCategoriaF.ShowModal;
  finally
    SelecionarCategoriaF.Free;
  end;
end;

procedure TCadastroProdutoF.DBGrid1DblClick(Sender: TObject);
begin
  inherited;
  TabelaProduto.Edit;
end;


procedure TCadastroProdutoF.BtnNovoClick(Sender: TObject);
begin
  inherited;
  TabelaProduto.Append;
  TabelaProdutodt_cadastro_produto.AsDateTime := StrToDate(formatdatetime('dd/mm/yyyy', now));
  DBRadioGroup1.ItemIndex := 0;
end;

procedure TCadastroProdutoF.BtnGravarClick(Sender: TObject);
begin
       if DBeditCategoriaID.Text = '' then
  begin
    ShowMessage('Informe a categoria para cadastrar o produto!');
     BtnPesquisarIDcate.SetFocus;
      Exit;
  end;

   if DBEdit5.Text = '' then
  begin
    ShowMessage('Informe a data de cadastro!');
     DBEdit5.SetFocus;
      Exit;
  end;

  if DBEdit6.Text = '' then
  begin
    ShowMessage('Informe o nome do produto que deseja cadastrar!');
     DBEdit6.SetFocus;
      Exit;
  end;

      if DBRadioGroup1.ItemIndex = -1 then
  begin
    ShowMessage('Selecione uma opção no grupo de categoria do produto!');
     DBRadioGroup1.SetFocus;
      Exit;
  end;

  if DBEdit4.Text = '' then
  begin
    ShowMessage('Informe o valor de venda do produto que deseja cadastrar!');
     DBEdit4.SetFocus;
      Exit;
  end;

  if DBEdit3.Text = '' then
  begin
    ShowMessage('Adicione pelo menos uma descrição ao produto!');
     DBEdit3.SetFocus;
      Exit;
  end;

  if DBRadioGroup1.ItemIndex = 1 then
begin
  if MessageDlg('Tem certeza que deseja inativar o produto? Ele ficará indisponível para novos orçamentos!',
                mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
     ShowMessage('Produto inativado!');
    end
    else
    exit;
   end;

    inherited;
    TabelaProduto.Post;
    TabelaProduto.ApplyUpdates;
end;

procedure TCadastroProdutoF.BtnExcluirClick(Sender: TObject);
var
  Total, ProdutoID: Integer;
  VerificarProdutoQuery: TZQuery;
begin

  if not TryStrToInt(DBEdit2.Text, ProdutoID) then
  begin
    ShowMessage('Erro: ID do produto inválido.');
    Exit;
  end;


  VerificarProdutoQuery := TZQuery.Create(nil);
  try
    VerificarProdutoQuery.Connection := TabelaProduto.Connection;
    VerificarProdutoQuery.SQL.Text := 'SELECT COUNT(*) FROM orcamento_item WHERE produtoid = :ProdutoID';
    VerificarProdutoQuery.ParamByName('ProdutoID').AsInteger := ProdutoID;

    VerificarProdutoQuery.Open;
    Total := VerificarProdutoQuery.Fields[0].AsInteger;

    if Total > 0 then
    begin
      ShowMessage('Erro: Não é possível excluir o produto, pois ele está vinculado a orçamentos.');
      Exit;
    end;
  finally
    VerificarProdutoQuery.Free;
  end;

  if MessageDlg('Tem certeza que deseja excluir o registro atual?', mtConfirmation,
    [mbYes, mbNo], 0) = mrYes then
  begin
    TabelaProduto.Delete;
    PageControl1.ActivePageIndex := 0;
  end;
end;

procedure TCadastroProdutoF.BtnCancelarClick(Sender: TObject);
begin
         if MessageDlg('Tem certeza que deseja cancelar?', mtConfirmation,
    [mbYes, mbNo], 0) = mrYes then
  begin
    TabelaProduto.Cancel;
    PageControl1.ActivePageIndex := 0;
  end;
end;

procedure TCadastroProdutoF.Label4Click(Sender: TObject);
begin

end;

procedure TCadastroProdutoF.MaskEdit1Change(Sender: TObject);
begin

end;

procedure TCadastroProdutoF.Panel3Click(Sender: TObject);
begin

end;

procedure TCadastroProdutoF.SpeedButton1Click(Sender: TObject);
begin
   TabelaProduto.close;
   if EditPesquisar.Text <> '' then
    TabelaProduto.SQL.Text := 'select * from produto where produtoid =' +
      EditPesquisar.Text
  else
    TabelaProduto.SQL.Text := 'select * from produto';
  TabelaProduto.Open;
end;

procedure TCadastroProdutoF.TabelaProdutoAfterInsert(DataSet: TDataSet);
begin
    TabelaProdutoprodutoid.AsInteger :=
    StrToInt(DataModuleF.getSequence('seq_produto_id'));
end;

end.

