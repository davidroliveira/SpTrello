unit View.ServerModule;

interface

uses
  Classes, SysUtils, uniGUIServer, uniGUIMainModule, uniGUIApplication, uIdCustomHTTPServer,
  uniGUITypes;

type
  TServerModule = class(TUniGUIServerModule)
  private
    { Private declarations }
  protected
    procedure FirstInit; override;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses
  UniGUIVars;

procedure TServerModule.FirstInit;
begin
  InitServerModule(Self);
end;

initialization
  RegisterServerModuleClass(TServerModule);
end.
