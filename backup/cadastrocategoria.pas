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
  private

  public

  end;

var
  CadastroCategoriaF: TCadastroCategoriaF;

implementation

{$R *.lfm}

end.

