unit Sobre;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls;

type

  { TSobreF }

  TSobreF = class(TForm)
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure Label2Click(Sender: TObject);
    procedure Label6Click(Sender: TObject);
  private

  public

  end;

var
  SobreF: TSobreF;

implementation

{$R *.lfm}

{ TSobreF }

procedure TSobreF.Label2Click(Sender: TObject);
begin

end;

procedure TSobreF.Label6Click(Sender: TObject);
begin

end;

procedure TSobreF.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  CloseAction:=caFree;
end;

end.

