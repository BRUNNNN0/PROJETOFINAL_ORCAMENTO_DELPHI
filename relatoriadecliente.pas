unit Relatoriadecliente;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Buttons,
  ZDataset, LR_Class, LR_DBSet;

type

  { TRelatoriadeclienteF }

  TRelatoriadeclienteF = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    frDBDataSet1: TfrDBDataSet;
    frReport1: TfrReport;
    qryCliente: TZQuery;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);

    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  RelatoriadeclienteF: TRelatoriadeclienteF;

implementation

{$R *.lfm}

{ TRelatoriadeclienteF }

procedure TRelatoriadeclienteF.FormCreate(Sender: TObject);
begin
  qryCliente.Active:=true;
end;



procedure TRelatoriadeclienteF.BitBtn1Click(Sender: TObject);
var
  RelatorioPath: string;
begin
  // Caminho do relatório
  RelatorioPath := ExtractFilePath(Application.ExeName) + 'RELATORIOS\RelatorioCliente.lrf';

  // Verifica se o arquivo existe antes de carregar
  if FileExists(RelatorioPath) then
  begin
    frReport1.LoadFromFile(RelatorioPath);
    frReport1.PrepareReport;
    frReport1.ShowReport;
  end
  else
    ShowMessage('Relatório não encontrado: ' + RelatorioPath);
end;

procedure TRelatoriadeclienteF.BitBtn2Click(Sender: TObject);
begin
  qryCliente.Close;
  Close;
end;

procedure TRelatoriadeclienteF.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  CloseAction:=caFree;
end;

end.

