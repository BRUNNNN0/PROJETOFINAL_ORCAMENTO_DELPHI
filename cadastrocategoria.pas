unit CadastroCategoria;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, XcadModelo;

type

  { TCadastroCategoriaF }

  TCadastroCategoriaF = class(TXcadModeloF)
    edirPesquisarID: TEdit;
    editCategoria: TEdit;
    editIDcate: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
  private

  public

  end;

var
  CadastroCategoriaF: TCadastroCategoriaF;

implementation

{$R *.lfm}

{ TCadastroCategoriaF }

procedure TCadastroCategoriaF.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
    CloseAction:= caFree;
end;

end.

