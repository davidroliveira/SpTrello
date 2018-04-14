unit Controller.MainModule;

interface

uses
  View.MainModule, uniGUIMainModule, SysUtils, Classes, UniGUIVars,
  View.ServerModule, uniGUIApplication, uniGUIForm;

type
  TControllerMainModule = class
  strict private
    FMainModule: TMainModule;
    class var FInstancia: TControllerMainModule;
    constructor CreatePrivate;
  protected
    property MainModule: TMainModule read FMainModule write FMainModule;
  public
    constructor Create;
    class function GetInstancia: TControllerMainModule;
    function GetFormInstance(InClass: TClass; AutoCreate: Boolean = True): TComponent;
  end;

implementation

constructor TControllerMainModule.Create;
begin
  raise Exception.Create('Só instância ' + Self.ClassName + ' permitido');
end;

constructor TControllerMainModule.CreatePrivate;
begin
  FMainModule := TMainModule(UniApplication.UniMainModule);
end;

function TControllerMainModule.GetFormInstance(InClass: TClass;
  AutoCreate: Boolean): TComponent;
begin
  Result := MainModule.GetFormInstance(InClass, AutoCreate);
end;

class function TControllerMainModule.GetInstancia: TControllerMainModule;
begin
  if not Assigned(FInstancia) then
    FInstancia := TControllerMainModule.CreatePrivate;
  Result := FInstancia;
end;

initialization
  RegisterMainModuleClass(TMainModule);
end.
