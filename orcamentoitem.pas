unit OrcamentoItem;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, DBCtrls,
  Buttons, SelecionarProduto, DataModule;

type

  { TOrcamentoItemF }

  TOrcamentoItemF = class(TForm)
    BtnCancelar: TBitBtn;
    BtnInserir: TBitBtn;
    Button1: TButton;
    DBEditIDproduto: TDBEdit;
    DBEditNMproduto: TDBEdit;
    DBEditVlunit: TDBEdit;
    DBEditVltotal: TDBEdit;
    EditIdproduto: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    procedure BtnCancelarClick(Sender: TObject);
    procedure BtnInserirClick(Sender: TObject);


    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure EditIdprodutoExit(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);



  private

  public

  end;

var
  OrcamentoItemF: TOrcamentoItemF;
  QTDE, VALOR, TOTAL: Double;


implementation

{$R *.lfm}
 uses
     FazerOrcamento;
{ TOrcamentoItemF }



procedure TOrcamentoItemF.Button1Click(Sender: TObject);
begin
    SelecionarProdutoF := TSelecionarProdutoF.Create(Self);
  try
    SelecionarProdutoF.ShowModal;
  finally
    SelecionarProdutoF.Free;
  end;
end;

procedure TOrcamentoItemF.Button3Click(Sender: TObject);
begin

end;

procedure TOrcamentoItemF.EditIdprodutoExit(Sender: TObject);

  var
  QTDE: Double;
begin
  while True do
  begin
    if Trim(OrcamentoItemF.EditIdproduto.Text) = '' then
    begin
      ShowMessage('Favor informar a quantidade do produto!');
      OrcamentoItemF.EditIdproduto.SetFocus;
      Exit;
    end;

    QTDE := StrToFloatDef(OrcamentoItemF.EditIdproduto.Text, -1);
    if QTDE <= 0 then
    begin
      ShowMessage('A quantidade deve ser maior que zero!');
      OrcamentoItemF.EditIdproduto.SetFocus;
      Exit;
    end;

    Break;
  end;
     FazerOrcamentoF.TabelaOrcamentoItemqt_produto.AsFloat := StrToFloat(OrcamentoItemF.EditIdproduto.Text);

  QTDE     := FazerOrcamentoF.TabelaOrcamentoItemqt_produto.AsFloat;
  VALOR  := FazerOrcamentoF.TabelaOrcamentoItemvl_unitario.AsFloat;

  if  QTDE > 0  then
  begin
    TOTAL := QTDE * VALOR;
    FazerOrcamentoF.TabelaOrcamentoItemvl_total.AsFloat := TOTAL;
    DBEditVltotal.Text := FloatToStr(TOTAL);
    end
end;

procedure TOrcamentoItemF.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  CloseAction := caFree;
end;


procedure TOrcamentoItemF.BtnCancelarClick(Sender: TObject);
begin
   FazerOrcamentoF.TabelaOrcamentoItem.Cancel;
   close;
end;

procedure TOrcamentoItemF.BtnInserirClick(Sender: TObject);
  begin
  if Trim(OrcamentoItemF.DBEditIDproduto.Text) = '' then
 begin
   ShowMessage('Favor informar o produto!');
   OrcamentoItemF.Button1.SetFocus;
   Exit;
 end;


   if Trim(OrcamentoItemF.EditIdproduto.Text) = '' then
 begin
   ShowMessage('Favor informar a quantidade do produto!');
   OrcamentoItemF.EditIdproduto.SetFocus;
   Exit;
 end;



  FazerOrcamentoF.TabelaOrcamentoItemqt_produto.AsString := OrcamentoItemF.EditIdproduto.Text;
  FazerOrcamentoF.TabelaOrcamentoItemvl_total.AsString := OrcamentoItemF.DBEditVltotal.Text;
  FazerOrcamentoF.TabelaOrcamentoItem.Post;
 Close;
end;







end.

