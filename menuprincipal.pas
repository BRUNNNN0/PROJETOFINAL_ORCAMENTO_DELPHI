unit MenuPrincipal;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Menus, CadastroCategoria;

type

  { TMenuPrincipalF }

  TMenuPrincipalF = class(TForm)
    MainMenu1: TMainMenu;
    MNCadastro: TMenuItem;
    MNprodutoR: TMenuItem;
    MenuItem11: TMenuItem;
    MNcategoriasR: TMenuItem;
    MNreltestclienteR: TMenuItem;
    MNSobre: TMenuItem;
    MNSair: TMenuItem;
    MNclienteC: TMenuItem;
    MNprodutoC: TMenuItem;
    MNusuariosC: TMenuItem;
    MNcategoriaC: TMenuItem;
    MNVendas: TMenuItem;
    MNorcamentoV: TMenuItem;
    MenuItem8: TMenuItem;
    MNclienteR: TMenuItem;
    procedure MNcategoriaCClick(Sender: TObject);
    procedure MNSairClick(Sender: TObject);
  private

  public

  end;

var
  MenuPrincipalF: TMenuPrincipalF;

implementation

{$R *.lfm}

{ TMenuPrincipalF }

procedure TMenuPrincipalF.MNSairClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TMenuPrincipalF.MNcategoriaCClick(Sender: TObject);
begin
  CadastroCategoriaF := TCadastroCategoriaF.Create(Self);
  CadastroCategoriaF.ShowModal;
end;


end.

