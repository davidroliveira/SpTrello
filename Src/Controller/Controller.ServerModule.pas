unit Controller.ServerModule;

interface

uses
  View.ServerModule, Classes, SysUtils, uniGUIServer, uniGUIMainModule, uniGUIApplication, uIdCustomHTTPServer,
  uniGUITypes;

function UniServerModule: TServerModule;

implementation

uses
  UniGUIVars;

function UniServerModule: TServerModule;
begin
  Result := TServerModule(UniGUIServerInstance);
end;

end.
