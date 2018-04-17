unit MainModule;

interface

uses
  uniGUIMainModule, SysUtils, Classes, UniGUIVars, ServerModule, uniGUIApplication,
  uniGUIBaseClasses, uniGUIClasses, uniImageList;

type
  TUniMainModule = class(TUniGUIMainModule)
    UniImageList: TUniImageList;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function UniMainModule: TUniMainModule;

implementation

{$R *.dfm}

function UniMainModule: TUniMainModule;
begin
  Result := TUniMainModule(UniApplication.UniMainModule)
end;

initialization
  RegisterMainModuleClass(TUniMainModule);
end.
