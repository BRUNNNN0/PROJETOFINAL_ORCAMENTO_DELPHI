unit CadastroCliente;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, DBCtrls,
  Menus, ActnList, LR_DBSet, LR_Class, ZDataset, ZSqlUpdate, ZAbstractRODataset,
  XcadModelo, DB;

type

  { TCadastroClienteF }

  TCadastroClienteF = class(TXcadModeloF)
    DataSource1: TDataSource;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBRadioGroup1: TDBRadioGroup;
    EditPesquisa: TEdit;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    TabelaCliente: TZQuery;
    TabelaClienteclienteid: TZIntegerField;
    TabelaClientecpf_cnpj_cliente: TZRawStringField;
    TabelaClientenome_cliente: TZRawStringField;
    TabelaClientetipo_cliente: TZRawStringField;
    ZQuery1: TZQuery;
    ZUpdateSQL1: TZUpdateSQL;


    procedure BtnCancelarClick(Sender: TObject);
    procedure BtnExcluirClick(Sender: TObject);
    procedure BtnGravarClick(Sender: TObject);
    procedure BtnNovoClick(Sender: TObject);
    procedure DataSource1DataChange(Sender: TObject; Field: TField);
    procedure DBEdit3Enter(Sender: TObject);
    procedure DBRadioGroup1Change(Sender: TObject);

    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);


    procedure SpeedButton1Click(Sender: TObject);
    procedure TabelaClienteAfterInsert(DataSet: TDataSet);

  private

  public

  end;

var
  CadastroClienteF: TCadastroClienteF;

implementation

{$R *.lfm}
uses
  DataModule;

{ TCadastroClienteF }

procedure TCadastroClienteF.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  CloseAction := caFree;
end;

procedure TCadastroClienteF.FormCreate(Sender: TObject);
begin
  TabelaCliente.Active := True;
  DBEdit3.Enabled := False;
end;

procedure TCadastroClienteF.DataSource1DataChange(Sender: TObject; Field: TField
  );
begin

end;

procedure TCadastroClienteF.DBEdit3Enter(Sender: TObject);
begin
  DBEdit3.Text:='';
end;

procedure TCadastroClienteF.DBRadioGroup1Change(Sender: TObject);
begin
  if DBRadioGroup1.ItemIndex = 0 then
  begin
    DBEdit3.CustomEditMask := True;
    DBEdit3.EditMask := '999.999.999-99;1;_';
    DBEdit3.Enabled := True;
  end
  else if DBRadioGroup1.ItemIndex = 1 then
  begin
    DBEdit3.CustomEditMask := True;
    DBEdit3.EditMask := '99.999.999/9999-99;1;_';
    DBEdit3.Enabled := True;
  end;
end;


procedure TCadastroClienteF.BtnNovoClick(Sender: TObject);
begin
  inherited;
  TabelaCliente.Append;
end;

procedure TCadastroClienteF.BtnGravarClick(Sender: TObject);
begin
  if DBEdit2.Text = '' then
  begin
  ShowMessage('Informe o nome ou a razão Social do cliente!');
  DBEdit2.SetFocus;
  Exit;
  end;

  if DBEdit3.Text = '' then
  begin
  ShowMessage('Informe o CPF ou o CNPJ do cliente!');
  DBRadioGroup1.SetFocus;
  Exit;
  end;

  inherited;
  TabelaCliente.Post;
  TabelaCliente.ApplyUpdates;
end;

procedure TCadastroClienteF.BtnExcluirClick(Sender: TObject);
var
  Total, ClienteID: Integer;
  VerificarClienteQuery: TZQuery;
begin

  if not TryStrToInt(DBEdit1.Text, ClienteID) then
  begin
    ShowMessage('Erro: ID do cliente inválido.');
    Exit;
  end;


  VerificarClienteQuery := TZQuery.Create(nil);
  try
    VerificarClienteQuery.Connection := TabelaCliente.Connection;
    VerificarClienteQuery.SQL.Text := 'SELECT COUNT(*) FROM orcamento WHERE clienteid = :ClienteID';
    VerificarClienteQuery.ParamByName('ClienteID').AsInteger := ClienteID;


    VerificarClienteQuery.Open;
    Total := VerificarClienteQuery.Fields[0].AsInteger;


    if Total > 0 then
    begin
      ShowMessage('Erro: Não é possível excluir o cliente, pois ele está vinculado a orçamentos.');
      Exit;
    end;
  finally
    VerificarClienteQuery.Free;
  end;


  if MessageDlg('Tem certeza que deseja excluir o registro atual?', mtConfirmation,
    [mbYes, mbNo], 0) = mrYes then
  begin

    TabelaCliente.Delete;
    PageControl1.ActivePageIndex := 0;
  end;
end;

procedure TCadastroClienteF.BtnCancelarClick(Sender: TObject);
begin
      if MessageDlg('Tem certeza que deseja cancelar?', mtConfirmation,
    [mbYes, mbNo], 0) = mrYes then
  begin
    TabelaCliente.Cancel;
    PageControl1.ActivePageIndex := 0;
  end;
end;


procedure TCadastroClienteF.SpeedButton1Click(Sender: TObject);
begin
  TabelaCliente.close;
   if EditPesquisa.Text <> '' then
    TabelaCliente.SQL.Text := 'select * from cliente where clienteid =' +
      EditPesquisa.Text
  else
    TabelaCliente.SQL.Text := 'select * from cliente';
  TabelaCliente.Open;
end;

procedure TCadastroClienteF.TabelaClienteAfterInsert(DataSet: TDataSet);
begin
    TabelaClienteclienteid.AsInteger :=
    StrToInt(DataModuleF.getSequence('seq_cliente_id'));
end;




end.

