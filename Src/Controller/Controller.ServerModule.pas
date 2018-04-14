unit Controller.ServerModule;

interface

uses
  View.ServerModule, Forms, Classes, SysUtils, uniGUIServer, uniGUIMainModule,
  uniGUIApplication, uIdCustomHTTPServer, uniGUITypes, UniGUIVars;

type
  TControllerServerModule = class
  strict private
    FServerModule: TServerModule;
    class var FInstancia: TControllerServerModule;
    constructor CreatePrivate;
  protected
    property ServerModule: TServerModule read FServerModule write FServerModule;
  public
    constructor Create;
    class function GetInstancia: TControllerServerModule;
  end;

implementation

constructor TControllerServerModule.Create;
begin
  raise Exception.Create('Só instância ' + Self.ClassName + ' permitido');
end;

constructor TControllerServerModule.CreatePrivate;
begin
  inherited Create;
  FServerModule := TServerModule.Create(Application);
end;

class function TControllerServerModule.GetInstancia: TControllerServerModule;
begin
  if not Assigned(FInstancia) then
    FInstancia := TControllerServerModule.CreatePrivate;
  Result := FInstancia;
end;

initialization
  RegisterServerModuleClass(TServerModule);
end.
