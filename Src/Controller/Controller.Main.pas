unit Controller.Main;

interface

uses
  View.Main, uniGUIMainModule, SysUtils, Classes, UniGUIVars,
  View.ServerModule, uniGUIApplication,

  Controller.MainModule;

type
  TControllerMain = class
  strict private
    FMain: TMain;
    class var FInstancia: TControllerMain;
    constructor CreatePrivate;
  protected
    property Main: TMain read FMain write FMain;
  public
   constructor Create;
    class function GetInstancia: TControllerMain;
  end;

implementation

constructor TControllerMain.Create;
begin
  raise Exception.Create('Só instância ' + Self.ClassName + ' permitido');
end;

constructor TControllerMain.CreatePrivate;
begin
  FMain := TMain(TControllerMainModule.GetInstancia.GetFormInstance(TMain));
end;

class function TControllerMain.GetInstancia: TControllerMain;
begin
  if not Assigned(FInstancia) then
    FInstancia := TControllerMain.CreatePrivate;
  Result := FInstancia;
end;

initialization
  RegisterAppFormClass(TMain);
end.
