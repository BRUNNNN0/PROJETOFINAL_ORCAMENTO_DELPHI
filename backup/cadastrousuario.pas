unit CadastroUsuario;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, DBCtrls,
  ZDataset, ZSqlUpdate, ZAbstractRODataset, XcadModelo, DB;

type

  { TCadastroUsuarioF }

  TCadastroUsuarioF = class(TXcadModeloF)
    DataSource1: TDataSource;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    EditPesquisa: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    TabelaUsuarios: TZQuery;
    TabelaUsuariosid: TZIntegerField;
    TabelaUsuariosnome_completo: TZRawStringField;
    TabelaUsuariossenha: TZRawStringField;
    TabelaUsuariosusuario: TZRawStringField;
    ZUpdateSQL1: TZUpdateSQL;
    procedure BtnCancelarClick(Sender: TObject);
    procedure BtnExcluirClick(Sender: TObject);
    procedure BtnGravarClick(Sender: TObject);
    procedure BtnNovoClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure Label5Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure TabelaUsuariosAfterInsert(DataSet: TDataSet);
  private

  public

  end;

var
  CadastroUsuarioF: TCadastroUsuarioF;

implementation

{$R *.lfm}

uses
  DataModule;

{ TCadastroUsuarioF }

procedure TCadastroUsuarioF.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  CloseAction := caFree;
end;

procedure TCadastroUsuarioF.FormCreate(Sender: TObject);
begin
  TabelaUsuarios.Active := True;
end;

procedure TCadastroUsuarioF.BtnNovoClick(Sender: TObject);
begin
  inherited;
  TabelaUsuarios.Append;
end;

procedure TCadastroUsuarioF.BtnGravarClick(Sender: TObject);
begin
    if DBEdit2.Text = '' then
  begin
    ShowMessage('Informe o nome do novo usúario!');
     DBEdit2.SetFocus;
      Exit;
  end;

    if DBEdit3.Text = '' then
  begin
    ShowMessage('Crie um nome de usúario para ' + DBEdit2.Text + ' !');
     DBEdit3.SetFocus;
      Exit;
  end;

    if DBEdit4.Text = '' then
  begin
    ShowMessage('Crie uma nova senha para o usúario!');
     DBEdit4.SetFocus;
      Exit;
  end;

  inherited;
  TabelaUsuarios.Post;
  TabelaUsuarios.ApplyUpdates;
end;

procedure TCadastroUsuarioF.BtnExcluirClick(Sender: TObject);
begin
   if MessageDlg('Tem certeza que deseja excluir o registro atual?', mtConfirmation,
    [mbYes, mbNo], 0) = mrYes then
  begin
    TabelaUsuarios.Delete;
    PageControl1.ActivePageIndex := 0;
  end;
end;

procedure TCadastroUsuarioF.BtnCancelarClick(Sender: TObject);
begin
       if MessageDlg('Tem certeza que deseja cancelar?', mtConfirmation,
    [mbYes, mbNo], 0) = mrYes then
  begin
    TabelaUsuarios.Cancel;
    PageControl1.ActivePageIndex := 0;
  end;
end;

procedure TCadastroUsuarioF.Label5Click(Sender: TObject);
begin

end;

procedure TCadastroUsuarioF.SpeedButton1Click(Sender: TObject);
begin
    TabelaUsuarios.close;
   if EditPesquisa.Text <> '' then
    TabelaUsuarios.SQL.Text := 'select * from usuarios where id =' +
      EditPesquisa.Text
  else
    TabelaUsuarios.SQL.Text := 'select * from usuarios';
  TabelaUsuarios.Open;
end;

procedure TCadastroUsuarioF.TabelaUsuariosAfterInsert(DataSet: TDataSet);
begin
  TabelaUsuariosid.AsInteger :=
    StrToInt(DataModuleF.getSequence('seq_usuario_id'));
end;

end.

