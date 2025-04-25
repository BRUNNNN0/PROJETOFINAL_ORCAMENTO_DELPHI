unit TeladeLogin;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  Buttons, ZDataset, DataModule, MenuPrincipal, RedefinirSenha;

type

  { TTeladeLoginF }

  TTeladeLoginF = class(TForm)
    BitBtn1: TBitBtn;
    btnLogin: TButton;
    edtUsuario: TEdit;
    edtSenha: TEdit;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    procedure BitBtn1Click(Sender: TObject);
    procedure btnLoginClick(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure Label3Click(Sender: TObject);
    procedure Label3MouseEnter(Sender: TObject);
    procedure Label3MouseLeave(Sender: TObject);



  private

  public
    function ValidaUsuario(pUsuario: String; pSenha: String): Boolean;

  end;

var
  TeladeLoginF: TTeladeLoginF;

implementation

{$R *.lfm}

{ TTeladeLoginF }

procedure TTeladeLoginF.btnLoginClick(Sender: TObject);
begin

if ValidaUsuario(edtUsuario.Text,edtSenha.Text) = True then
  MenuPrincipalF.Show;

end;



procedure TTeladeLoginF.BitBtn1Click(Sender: TObject);
begin
if edtSenha.PasswordChar = '*' then
begin
  edtSenha.PasswordChar := #0;
end
else
begin
  edtSenha.PasswordChar := '*';
end;
end;

procedure TTeladeLoginF.Image1Click(Sender: TObject);
begin

end;

procedure TTeladeLoginF.Label3Click(Sender: TObject);
begin
      RedefinirSenhaF := TRedefinirSenhaF.Create(Self);
      RedefinirSenhaF.Show;
end;

procedure TTeladeLoginF.Label3MouseEnter(Sender: TObject);
begin
  Label3.Font.Color:= clBlue;
end;

procedure TTeladeLoginF.Label3MouseLeave(Sender: TObject);
begin
  Label3.Font.Color:= clBlack;
end;




function TTeladeLoginF.ValidaUsuario(pUsuario: String; pSenha: String
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
  ShowMessage('Favor Preencha a Senha!');
  edtSenha.SetFocus;
  Exit;
end;

DataModuleF.ZGenerica1.Close;
DataModuleF.ZGenerica1.SQL.Clear;
DataModuleF.ZGenerica1.SQL.Add('SELECT COUNT(*) AS NUMBER '+
                                'FROM USUARIOS '+
                                'WHERE USUARIO = ' +  QuotedStr(pUsuario) + ' ' +
                                'AND SENHA = ' + QuotedStr(pSenha));
DataModuleF.ZGenerica1.Open;

if DataModuleF.ZGenerica1.FieldByName('NUMBER').AsInteger > 0 then
begin
 Result := True;
  Self.Hide;
end
else
begin
  ShowMessage('Senha ou Usuário incorretos!');
  edtUsuario.SetFocus;
end;
end;





end.

