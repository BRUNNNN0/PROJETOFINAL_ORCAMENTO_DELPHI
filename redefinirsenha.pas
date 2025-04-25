unit RedefinirSenha;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  DataModule;

type

  { TRedefinirSenhaF }

  TRedefinirSenhaF = class(TForm)
    btnSalvar: TButton;
    btnCancelar: TButton;
    edtSenha: TEdit;
    edtUsuario: TEdit;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    procedure btnCancelarClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);

    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure Image1Click(Sender: TObject);
  private

  public
    function redefinir(pUsuario: String; pSenha: String): Boolean;
  end;

var
  RedefinirSenhaF: TRedefinirSenhaF;

implementation

{$R *.lfm}



{ TRedefinirSenhaF }

procedure TRedefinirSenhaF.btnSalvarClick(Sender: TObject);
begin
  redefinir(edtUsuario.Text,edtSenha.Text);


end;

procedure TRedefinirSenhaF.btnCancelarClick(Sender: TObject);
begin
  close;
end;



procedure TRedefinirSenhaF.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  CloseAction := caFree;
end;

procedure TRedefinirSenhaF.Image1Click(Sender: TObject);
begin

end;

function TRedefinirSenhaF.redefinir(pUsuario: String; pSenha: String
  ): Boolean;
begin
Result := False;


if Trim(pUsuario) = '' then
begin
  ShowMessage('Favor Preencha o Usuário!');
  edtUsuario.SetFocus;
  Exit;
end;

if Trim(pSenha) = '' then
begin
  ShowMessage('Informe a nova Senha!');
  edtSenha.SetFocus;
  Exit;
end;
DataModuleF.ZGenerica1.Close;
DataModuleF.ZGenerica1.SQL.Clear;
DataModuleF.ZGenerica1.SQL.Add('UPDATE USUARIOS ' +
                                'SET SENHA = ' + QuotedStr(pSenha) + ' ' +
                                'WHERE USUARIO = ' + QuotedStr(pUsuario));
DataModuleF.ZGenerica1.ExecSQL;

ShowMessage('Senha alterada com sucesso!');
Close;
end;

end.

