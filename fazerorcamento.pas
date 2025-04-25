unit FazerOrcamento;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, DBGrids, Buttons,
  DBCtrls, StdCtrls, ZSqlUpdate, ZDataset, ZAbstractRODataset,
  XcadModelo, DB, OrcamentoItem, SelecionarClientes;

type

  { TFazerOrcamentoF }

  TFazerOrcamentoF = class(TXcadModeloF)
    btnExcluirItem: TBitBtn;
    btnAdicionarItem: TBitBtn;
    btnSelecionarClientes: TButton;
    DataSource1: TDataSource;
    DataScadastro: TDataSource;
    editPesquisarOrc: TEdit;
    editVLtotal: TDBEdit;
    editIDorcamento: TDBEdit;
    editIDcliente: TDBEdit;
    editDTorcamento: TDBEdit;
    editDTvalidade: TDBEdit;
    DBGrid2: TDBGrid;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    TabelaOrcamento: TZQuery;
    TabelaOrcamentoclienteid: TZIntegerField;
    TabelaOrcamentodt_orcamento: TZDateTimeField;
    TabelaOrcamentodt_validade_orcamento: TZDateTimeField;
    TabelaOrcamentoItemorcamentoid: TZIntegerField;
    TabelaOrcamentoItemorcamentoitemid: TZIntegerField;
    TabelaOrcamentoItemprodutodesc: TZRawStringField;
    TabelaOrcamentoItemprodutoid: TZIntegerField;
    TabelaOrcamentoItemqt_produto: TZBCDField;
    TabelaOrcamentoItemvl_total: TZBCDField;
    TabelaOrcamentoItemvl_unitario: TZBCDField;
    TabelaOrcamentoorcamentoid: TZIntegerField;
    TabelaOrcamentovl_total_orcamento: TZBCDField;
    TabelaOrcamentoItem: TZQuery;
    ZUpdateSQL1: TZUpdateSQL;
    procedure btnAdicionarItemClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure BtnExcluirClick(Sender: TObject);
    procedure btnExcluirItemClick(Sender: TObject);
    procedure BtnGravarClick(Sender: TObject);
    procedure BtnNovoClick(Sender: TObject);
    procedure btnSelecionarClientesClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure DBGrid2DblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure TabelaOrcamentoAfterInsert(DataSet: TDataSet);
    procedure TabelaOrcamentoItemAfterPost(DataSet: TDataSet);



  private

  public
    procedure Abrirorcamento(orcamentoid: integer);
    procedure SomarItens;
  end;

var
  FazerOrcamentoF: TFazerOrcamentoF;

implementation

{$R *.lfm}

uses
  DataModule;

  { TFazerOrcamentoF }

procedure TFazerOrcamentoF.SomarItens;
begin

  if not (FazerOrcamentoF.TabelaOrcamento.State in [dsEdit, dsInsert]) then
    FazerOrcamentoF.TabelaOrcamento.Edit;

  if not (FazerOrcamentoF.TabelaOrcamentoItem.State in [dsEdit, dsInsert]) then
    FazerOrcamentoF.TabelaOrcamentoItem.Edit;

  //Vai pro Primeiro
  FazerOrcamentoF.TabelaOrcamentoItem.First;
  FazerOrcamentoF.TabelaOrcamentovl_total_orcamento.AsFloat := 0;

  while not FazerOrcamentoF.TabelaOrcamentoItem.EOF do
  begin
    FazerOrcamentoF.TabelaOrcamentovl_total_orcamento.AsFloat :=
      FazerOrcamentoF.TabelaOrcamentovl_total_orcamento.AsFloat +
      FazerOrcamentoF.TabelaOrcamentoItemvl_total.AsFloat;
    FazerOrcamentoF.TabelaOrcamentoItem.Next;

  end;
end;


procedure TFazerOrcamentoF.btnAdicionarItemClick(Sender: TObject);
begin

  if editIDcliente.Text = '' then
  begin
    ShowMessage('Selecionar Cliente antes de prosseguir');
     btnSelecionarClientes.SetFocus;
     Exit;
  end;

  TabelaOrcamentoItem.Insert;
  TabelaOrcamentoItemorcamentoid.AsInteger := StrToInt(editIDorcamento.Text);
  TabelaOrcamentoItemorcamentoitemid.AsInteger :=
    StrToInt(DataModuleF.getSequence('seq_orcamentoitem_id'));
  OrcamentoItemF := TOrcamentoItemF.Create(Self);
  try


  OrcamentoItemF.DBEditIDproduto.Text := '';
  OrcamentoItemF.DBEditNMproduto.Text := '';
  OrcamentoItemF.DBEditVlunit.Text := '';
  OrcamentoItemF.DBEditVltotal.Text := '';


    if OrcamentoItemF.ShowModal = mrOk then
    begin

      TabelaOrcamentoItem.Post;

    end;

  finally
    OrcamentoItemF.Free;
  end;
end;

procedure TFazerOrcamentoF.BtnCancelarClick(Sender: TObject);
begin

  if MessageDlg('Tem certeza que deseja cancelar?', mtConfirmation,
    [mbYes, mbNo], 0) = mrYes then
  begin
    TabelaOrcamento.Cancel;
    inherited;
  end;
end;

procedure TFazerOrcamentoF.BtnExcluirClick(Sender: TObject);
begin



           if MessageDlg('Tem certeza que deseja excluir o registro atual?', mtConfirmation,
    [mbYes, mbNo], 0) = mrYes then
  begin
    TabelaOrcamentoItem.Close;
    TabelaOrcamentoItem.SQL.Clear;
    TabelaOrcamentoItem.SQL.Add('DELETE FROM ORCAMENTO_ITEM WHERE ORCAMENTOID = :orcamentoid');
    TabelaOrcamentoItem.Params.ParamByName('orcamentoid').AsInteger := TabelaOrcamentoorcamentoid.AsInteger;
    TabelaOrcamentoItem.ExecSQL;

    TabelaOrcamento.Delete;
    PageControl1.ActivePageIndex := 0;
  end;
end;

procedure TFazerOrcamentoF.btnExcluirItemClick(Sender: TObject);
begin
    if TabelaOrcamentoItem.IsEmpty then
  begin
    ShowMessage('Não há itens para excluir no momento!.');
    Exit;
  end;

      if MessageDlg('Tem certeza que deseja excluir o item atual?', mtConfirmation,
    [mbYes, mbNo], 0) = mrYes then
  begin
  TabelaOrcamentoItem.Delete;
  FazerOrcamentoF.SomarItens;
end;
end;

procedure TFazerOrcamentoF.BtnGravarClick(Sender: TObject);
begin
  if Trim(editIDcliente.Text) = '' then
  begin
    ShowMessage('Favor informar o cliente!');
    btnSelecionarClientes.SetFocus;
    Exit;
  end;


  if TabelaOrcamentoItem.IsEmpty then
  begin
    ShowMessage('Adicione pelo menos um item antes de salvar o orçamento.');
    Exit;
  end;

  inherited;
  TabelaOrcamento.Post;
  TabelaOrcamento.ApplyUpdates;
  TabelaOrcamentoItem.ApplyUpdates;
end;

procedure TFazerOrcamentoF.BtnNovoClick(Sender: TObject);
begin
  inherited;
  TabelaOrcamento.Insert;
  TabelaOrcamentoorcamentoid.AsInteger :=
    StrToInt(DataModuleF.getSequence('seq_orcamento_id'));
  editIDorcamento.Text := IntToStr(TabelaOrcamentoorcamentoid.AsInteger);
  Abrirorcamento(TabelaOrcamentoorcamentoid.AsInteger);
end;

procedure TFazerOrcamentoF.btnSelecionarClientesClick(Sender: TObject);
begin
  SelecionarClientesF := TSelecionarClientesF.Create(Self);
  try
    SelecionarClientesF.ShowModal;
  finally
    SelecionarClientesF.Free;
  end;
end;

procedure TFazerOrcamentoF.DBGrid1DblClick(Sender: TObject);
begin
  editIDorcamento.Text := IntToStr(TabelaOrcamentoorcamentoid.AsInteger);
  editIDcliente.Text := IntToStr(TabelaOrcamentoclienteid.AsInteger);
  TabelaOrcamento.Edit;
  Abrirorcamento(TabelaOrcamentoorcamentoid.AsInteger);
end;

procedure TFazerOrcamentoF.DBGrid2DblClick(Sender: TObject);
begin
  OrcamentoItemF := TOrcamentoItemF.Create(Self);
  try
    // Verificar se há um item selecionado
    if TabelaOrcamentoItem.IsEmpty then
      Exit;
    if TabelaOrcamentoItem.State = dsBrowse then
      TabelaOrcamentoItem.Edit;
    if OrcamentoItemF.ShowModal = mrOk then
    begin
      // Salvar as alterações na tabela de itens
      TabelaOrcamentoItem.Post;

      // Recalcular o total do orçamento, se necessário
      SomarItens;  // Se necessário
    end;

  finally
    OrcamentoItemF.Free;
  end;
end;

procedure TFazerOrcamentoF.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  CloseAction := caFree;
end;

procedure TFazerOrcamentoF.FormCreate(Sender: TObject);
begin
  TabelaOrcamento.Active:=true;
  TabelaOrcamentoItem.Active:=true;
end;

procedure TFazerOrcamentoF.PageControl1Change(Sender: TObject);
begin
  Abrirorcamento(TabelaOrcamentoorcamentoid.AsInteger);
end;

procedure TFazerOrcamentoF.SpeedButton1Click(Sender: TObject);
begin

     TabelaOrcamento.close;
   if editPesquisarOrc.Text <> '' then
    TabelaOrcamento.SQL.Text := 'select * from orcamento where orcamentoid =' +
      editPesquisarOrc.Text
  else
    TabelaOrcamento.SQL.Text := 'select * from orcamento';
  TabelaOrcamento.Open;

end;

procedure TFazerOrcamentoF.TabelaOrcamentoAfterInsert(DataSet: TDataSet);
begin
  TabelaOrcamentoorcamentoid.AsInteger :=
    StrToInt(DataModuleF.getSequence('seq_orcamento_id'));
  TabelaOrcamentodt_orcamento.AsDateTime :=
    StrToDate(formatdatetime('dd/mm/yyyy', now));
  TabelaOrcamentodt_validade_orcamento.AsDateTime :=
    StrToDate(formatdatetime('dd/mm/yyyy', now + 15));
end;

procedure TFazerOrcamentoF.TabelaOrcamentoItemAfterPost(DataSet: TDataSet);
begin
  FazerOrcamentoF.SomarItens;
end;



procedure TFazerOrcamentoF.Abrirorcamento(orcamentoid: integer);
begin
  if orcamentoid <> 0 then
  begin
    TabelaOrcamentoItem.Close;
    TabelaOrcamentoItem.SQL.Clear;
    TabelaOrcamentoItem.SQL.Add(
      'SELECT ' + 'ORCAMENTOITEMID, ' + 'ORCAMENTOID, ' + 'PRODUTOID, ' +
      'produtodesc, ' + 'QT_PRODUTO, ' + 'VL_UNITARIO, ' + 'VL_TOTAL ' +
      'FROM ORCAMENTO_ITEM ' + 'WHERE ORCAMENTOID = ' + IntToStr(orcamentoid) +
      ' ' + 'ORDER BY ORCAMENTOID');
    TabelaOrcamentoItem.Open;
    PageControl1.ActivePageIndex := 1;
  end;
end;


end.

