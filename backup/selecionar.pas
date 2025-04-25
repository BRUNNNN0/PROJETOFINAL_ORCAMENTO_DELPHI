unit Selecionar;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, ExtCtrls,
  DBGrids, StdCtrls, Buttons;

type

  { TSelecionarF }

  TSelecionarF = class(TForm)
    DBGrid1: TDBGrid;
    EditPesquisarSC: TEdit;
    Label1: TLabel;
    PageControl1: TPageControl;
    Panel1: TPanel;
    SpeedButton1: TSpeedButton;
  private

  public

  end;

var
  SelecionarF: TSelecionarF;

implementation

{$R *.lfm}

end.

