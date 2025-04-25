unit MenuPrincipal;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Menus, ExtCtrls,
  CadastroCategoria, CadastroCliente, CadastroProduto, CadastroUsuario,
  FazerOrcamento, Relatoriadecliente, RelatoriadeProdutos, RelatoriaGeralOrcamento,
  relatorioDetalhadoorcamento, Sobre, RelatorioCategoria;

type

  { TMenuPrincipalF }

  TMenuPrincipalF = class(TForm)
    Image1: TImage;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MNCadastro: TMenuItem;
    MNprodutoR: TMenuItem;
    MenuItem11: TMenuItem;
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
    procedure FormCreate(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MNcategoriaCClick(Sender: TObject);
    procedure MNcategoriasRClick(Sender: TObject);
    procedure MNclienteCClick(Sender: TObject);
    procedure MNclienteRClick(Sender: TObject);

    procedure MNorcamentoVClick(Sender: TObject);
    procedure MNprodutoCClick(Sender: TObject);
    procedure MNprodutoRClick(Sender: TObject);
    procedure MNSairClick(Sender: TObject);
    procedure MNSobreClick(Sender: TObject);
    procedure MNusuariosCClick(Sender: TObject);
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

procedure TMenuPrincipalF.MNSobreClick(Sender: TObject);
begin
  SobreF := TSobreF.Create(Self);
  SobreF.ShowModal;
end;

procedure TMenuPrincipalF.MNusuariosCClick(Sender: TObject);
begin
  CadastroUsuarioF := TCadastroUsuarioF.Create(Self);
  CadastroUsuarioF.ShowModal;
end;

procedure TMenuPrincipalF.MNcategoriaCClick(Sender: TObject);
begin
  CadastroCategoriaF := TCadastroCategoriaF.Create(Self);
  CadastroCategoriaF.ShowModal;
end;

procedure TMenuPrincipalF.MNcategoriasRClick(Sender: TObject);
begin

end;

procedure TMenuPrincipalF.MenuItem1Click(Sender: TObject);
begin
  RelatoriaGeralOrcamentoF := TRelatoriaGeralOrcamentoF.Create(Self);
  RelatoriaGeralOrcamentoF.ShowModal;
end;

procedure TMenuPrincipalF.FormCreate(Sender: TObject);
begin

end;

procedure TMenuPrincipalF.Image1Click(Sender: TObject);
begin

end;

procedure TMenuPrincipalF.MenuItem2Click(Sender: TObject);
begin
  relatorioDetalhadoorcamentoF := TrelatorioDetalhadoorcamentoF.Create(Self);
  relatorioDetalhadoorcamentoF.ShowModal;
end;

procedure TMenuPrincipalF.MenuItem3Click(Sender: TObject);
begin
  RelatorioCategoriaF := TRelatorioCategoriaF.Create(Self);
  RelatorioCategoriaF.ShowModal;
end;

procedure TMenuPrincipalF.MNclienteCClick(Sender: TObject);
begin
  CadastroClienteF := TCadastroClienteF.Create(Self);
  CadastroClienteF.ShowModal;
end;

procedure TMenuPrincipalF.MNclienteRClick(Sender: TObject);
begin
  RelatoriadeclienteF := TRelatoriadeclienteF.Create(Self);
  RelatoriadeclienteF.ShowModal;
end;




procedure TMenuPrincipalF.MNorcamentoVClick(Sender: TObject);
begin
  FazerOrcamentoF := TFazerOrcamentoF.Create(Self);
  FazerOrcamentoF.ShowModal;
end;

procedure TMenuPrincipalF.MNprodutoCClick(Sender: TObject);
begin
  CadastroProdutoF := TCadastroProdutoF.Create(Self);
  CadastroProdutoF.ShowModal;
end;

procedure TMenuPrincipalF.MNprodutoRClick(Sender: TObject);
begin
  RelatoriadeProdutosF := TRelatoriadeProdutosF.Create(Self);
  RelatoriadeProdutosF.ShowModal;
end;


end.

