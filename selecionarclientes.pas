unit SelecionarClientes;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ZDataset,
  ZAbstractRODataset, Selecionar, DB;

type

  { TSelecionarClientesF }

  TSelecionarClientesF = class(TSelecionarF)
    DataSource1: TDataSource;
    ZQuery1: TZQuery;
    ZQuery1clienteid: TZIntegerField;
    ZQuery1nome_cliente: TZRawStringField;
    procedure DBGrid1DblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);

  private

  public

  end;

var
  SelecionarClientesF: TSelecionarClientesF;

implementation

{$R *.lfm}
  uses
    FazerOrcamento;
{ TSelecionarClientesF }



procedure TSelecionarClientesF.DBGrid1DblClick(Sender: TObject);
begin
      FazerOrcamentoF.editIDcliente.Text :=
    ZQuery1.FieldByName('clienteid').AsString;
  ;
  FazerOrcamentoF.TabelaOrcamentoclienteid.AsInteger := ZQuery1.FieldByName('clienteid').AsInteger;;

  SelecionarClientesF.Close;
end;

procedure TSelecionarClientesF.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  CloseAction := caFree;
end;

procedure TSelecionarClientesF.FormCreate(Sender: TObject);
begin
  ZQuery1.Active:=true;
end;

procedure TSelecionarClientesF.SpeedButton1Click(Sender: TObject);
begin
  begin
     ZQuery1.close;
   if EditPesquisarSC.Text <> '' then
    ZQuery1.SQL.Text := 'select clienteid, nome_cliente from cliente where clienteid =' +
    EditPesquisarSC.Text
  else
    ZQuery1.SQL.Text := 'select clienteid, nome_cliente from cliente';
  ZQuery1.Open;
end;
end;

end.

