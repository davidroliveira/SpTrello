unit Controller.MainModule;

interface

uses
  View.MainModule, uniGUIMainModule, SysUtils, Classes;


function UniMainModule: TMainModule;

implementation

uses
  UniGUIVars, View.ServerModule, uniGUIApplication;

function UniMainModule: TMainModule;
begin
  Result := TMainModule(UniApplication.UniMainModule)
end;

end.
