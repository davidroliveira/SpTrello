unit View.ServerModule;

interface

uses
  Classes, SysUtils, uniGUIServer, uniGUIMainModule, uniGUIApplication, uIdCustomHTTPServer,
  uniGUITypes, UniGUIVars;

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

procedure TServerModule.FirstInit;
begin
  InitServerModule(Self);
end;

end.
