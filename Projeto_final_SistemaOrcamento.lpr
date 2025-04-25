program Projeto_final_SistemaOrcamento;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  {$IFDEF HASAMIGA}
  athreads,
  {$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, zcomponent, zplain, zparsesql, zcore, XcadModelo, MenuPrincipal,
  CadastroCategoria, CadastroCliente, CadastroProduto, CadastroUsuario,
  DataModule, Selecionar, SelecionarCategoria, FazerOrcamento, OrcamentoItem,
  SelecionarProduto, SelecionarClientes, TeladeLogin, RedefinirSenha,
  Relatoriadecliente, Relatorio, RelatoriadeProdutos, RelatoriaGeralOrcamento,
  relatorioDetalhadoorcamento, Sobre, RelatorioCategoria;

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Title:='Eight Orçamentos';
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TTeladeLoginF, TeladeLoginF);
  Application.CreateForm(TDataModuleF, DataModuleF);
  Application.CreateForm(TMenuPrincipalF, MenuPrincipalF);
  Application.Run;
end.

