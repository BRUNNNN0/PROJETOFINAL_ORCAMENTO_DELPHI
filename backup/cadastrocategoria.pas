unit CadastroCategoria;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, DBCtrls,
  ZDataset, ZSqlUpdate, ZAbstractRODataset, XcadModelo, DB;

type

  { TCadastroCategoriaF }

  TCadastroCategoriaF = class(TXcadModeloF)

    DataSource1: TDataSource;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    edirPesquisarID: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    ZCadastro1: TZQuery;
    ZCadastro1categoriaprodutoid: TZIntegerField;
    ZCadastro1ds_categoria_produto: TZRawStringField;
    ZQuery1: TZQuery;
    ZUpdateSQL1: TZUpdateSQL;

    procedure BtnCancelarClick(Sender: TObject);
    procedure BtnExcluirClick(Sender: TObject);
    procedure BtnGravarClick(Sender: TObject);
    procedure BtnNovoClick(Sender: TObject);
    procedure DataSource1DataChange(Sender: TObject; Field: TField);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);

    procedure SpeedButton1Click(Sender: TObject);
    procedure ZCadastro1AfterInsert(DataSet: TDataSet);
  private

  public

  end;

var
  CadastroCategoriaF: TCadastroCategoriaF;

implementation

{$R *.lfm}

uses
  DataModule;

  { TCadastroCategoriaF }

procedure TCadastroCategoriaF.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  CloseAction := caFree;
end;

procedure TCadastroCategoriaF.FormCreate(Sender: TObject);
begin
  ZCadastro1.Active:= True;
end;



procedure TCadastroCategoriaF.SpeedButton1Click(Sender: TObject);
begin
  ZCadastro1.Close;
  if edirPesquisarID.Text <> '' then
    ZCadastro1.SQL.Text := 'select * from categoria_produto where categoriaprodutoid =' +
      edirPesquisarID.Text
  else
    ZCadastro1.SQL.Text := 'select * from categoria_produto';
  ZCadastro1.Open;
end;



procedure TCadastroCategoriaF.ZCadastro1AfterInsert(DataSet: TDataSet);
begin
  ZCadastro1categoriaprodutoid.AsInteger :=
    StrToInt(DataModuleF.getSequence('categoria_produto_id'));
  ;
end;

procedure TCadastroCategoriaF.DataSource1DataChange(Sender: TObject; Field: TField);
begin

end;

procedure TCadastroCategoriaF.BtnGravarClick(Sender: TObject);
begin

  ZCadastro1.Post;
  ZCadastro1.ApplyUpdates;
  PageControl1.ActivePageIndex := 0;
end;

procedure TCadastroCategoriaF.BtnCancelarClick(Sender: TObject);
begin
  if MessageDlg('Tem certeza que deseja cancelar?', mtConfirmation,
    [mbYes, mbNo], 0) = mrYes then
  begin
    ZCadastro1.Cancel;
    PageControl1.ActivePageIndex := 0;
  end;
end;

procedure TCadastroCategoriaF.BtnExcluirClick(Sender: TObject);
  var
    Total, CategoriaID: Integer;
    VerificarCategoriaQuery: TZQuery;
  begin

    if not TryStrToInt(DBEdit1.Text, CategoriaID) then
    begin
      ShowMessage('Erro: ID da categoria inválido.');
      Exit;
    end;


    VerificarCategoriaQuery := TZQuery.Create(nil);
    try
      VerificarCategoriaQuery.Connection := ZCadastro1.Connection;
      VerificarCategoriaQuery.SQL.Text := 'SELECT COUNT(*) FROM produto WHERE categoriaprodutoid = :CategoriaID';
      VerificarCategoriaQuery.ParamByName('CategoriaID').AsInteger := CategoriaID;


      VerificarCategoriaQuery.Open;
      Total := VerificarCategoriaQuery.Fields[0].AsInteger;


      if Total > 0 then
      begin
        ShowMessage('Erro: Não é possível excluir a categoria, pois ela está vinculada a produtos.');
        Exit;
      end;
    finally
      VerificarCategoriaQuery.Free;
    end;


    if MessageDlg('Tem certeza que deseja excluir a categoria atual?', mtConfirmation,
      [mbYes, mbNo], 0) = mrYes then
    begin

      ZCadastro1.Delete;
      PageControl1.ActivePageIndex := 0;
    end;
  end;

procedure TCadastroCategoriaF.BtnNovoClick(Sender: TObject);
begin
  ZCadastro1.Append;
  PageControl1.ActivePageIndex := 1;
end;



end.

