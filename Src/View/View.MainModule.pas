unit View.MainModule;

interface

uses
  uniGUIMainModule, SysUtils, Classes;

type
  TMainModule = class(TUniGUIMainModule)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses
  UniGUIVars;

initialization
  RegisterMainModuleClass(TMainModule);
end.
