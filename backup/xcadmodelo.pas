unit XcadModelo;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, ExtCtrls,
  Buttons, StdCtrls, DBGrids;

type

  { TXcadModeloF }

  TXcadModeloF = class(TForm)
    BtnCancelar: TBitBtn;
    BtnExcluir: TBitBtn;
    BtnGravar: TBitBtn;
    BtnEditar: TBitBtn;
    BtnSair: TBitBtn;
    BtnNovo: TBitBtn;
    DBGrid1: TDBGrid;
    Label1: TLabel;
    PageControl1: TPageControl;
    AbaPesquisar: TTabSheet;
    AbaCadastro: TTabSheet;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    SpeedButton1: TSpeedButton;
    procedure BtnCancelarClick(Sender: TObject);
    procedure BtnEditarClick(Sender: TObject);
    procedure BtnExcluirClick(Sender: TObject);
    procedure BtnGravarClick(Sender: TObject);
    procedure BtnNovoClick(Sender: TObject);
    procedure BtnSairClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);

  private

  public

  end;

var
  XcadModeloF: TXcadModeloF;

implementation

{$R *.lfm}

{ TXcadModeloF }


procedure TXcadModeloF.FormShow(Sender: TObject);
begin
  PageControl1.ActivePageIndex := 0;
end;

procedure TXcadModeloF.BtnNovoClick(Sender: TObject);
begin
  PageControl1.ActivePageIndex := 1;
end;

procedure TXcadModeloF.BtnGravarClick(Sender: TObject);
begin
  PageControl1.ActivePageIndex := 0;
end;

procedure TXcadModeloF.BtnEditarClick(Sender: TObject);
begin
  PageControl1.ActivePageIndex := 0;
end;

procedure TXcadModeloF.BtnCancelarClick(Sender: TObject);
begin
  PageControl1.ActivePageIndex := 0;
end;

procedure TXcadModeloF.BtnExcluirClick(Sender: TObject);
begin
  if MessageDlg('Tem certeza que deseja excluir?', mtConfirmation,
    [mbYes, mbNo], 0) = mrYes then
  begin
    PageControl1.ActivePageIndex := 0;
    ShowMessage('Registro excluído com sucesso!');
  end;
end;

procedure TXcadModeloF.BtnSairClick(Sender: TObject);
begin
  Close;
end;

procedure TXcadModeloF.DBGrid1DblClick(Sender: TObject);
begin
  PageControl1.ActivePageIndex := 1;
end;

end.

