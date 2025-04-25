unit Relatorio;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Buttons;

type

  { TRelatorioF }

  TRelatorioF = class(TForm)
    btnGerar: TBitBtn;
    btnSair: TBitBtn;
    procedure btnSairClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
  private

  public

  end;

var
  RelatorioF: TRelatorioF;

implementation

{$R *.lfm}

{ TRelatorioF }

procedure TRelatorioF.btnSairClick(Sender: TObject);
begin
  close;
end;

procedure TRelatorioF.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  CloseAction:=caFree;
end;

end.

