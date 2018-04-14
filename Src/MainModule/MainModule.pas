unit MainModule;

interface

uses
  uniGUIMainModule, SysUtils, Classes, UniGUIVars;

type
  TUniMainModule = class(TUniGUIMainModule)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

initialization
  RegisterMainModuleClass(TUniMainModule);
end.
