unit Controller.Main;

interface

uses
  View.Main;

function MainForm: TMainForm;

implementation

uses
  uniGUIVars, Controller.MainModule;

function MainForm: TMainForm;
begin
  Result := TMainForm(UniMainModule.GetFormInstance(TMainForm));
end;

end.
