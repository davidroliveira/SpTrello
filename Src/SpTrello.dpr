program SpTrello;

uses
  Forms,
  View.ServerModule in 'View\View.ServerModule.pas' {ServerModule: TUniGUIServerModule},
  View.MainModule in 'View\View.MainModule.pas' {MainModule: TUniGUIMainModule},
  View.Main in 'View\View.Main.pas' {Main: TUniForm},
  SpTrello.Authenticator in 'Lib\Authenticator\SpTrello.Authenticator.pas',
  Core.SpTrello.Authenticator in 'Lib\Core\Core.SpTrello.Authenticator.pas',
  Core.SpTrello.Base in 'Lib\Core\Core.SpTrello.Base.pas',
  Core.SpTrello.RestClient in 'Lib\Core\Core.SpTrello.RestClient.pas',
  Core.SpTrello.RestRequest in 'Lib\Core\Core.SpTrello.RestRequest.pas',
  Core.SpTrello.RestResponse in 'Lib\Core\Core.SpTrello.RestResponse.pas',
  Core.SpTrello.Constants in 'Lib\Core\Core.SpTrello.Constants.pas',
  Core.SpTrello.Util in 'Lib\Core\Core.SpTrello.Util.pas',
  Core.SpTrello.Organizations in 'Lib\Core\Core.SpTrello.Organizations.pas',
  SpTrello.Organizations in 'Lib\Organizations\SpTrello.Organizations.pas',
  Core.SpTrello.Boards in 'Lib\Core\Core.SpTrello.Boards.pas',
  SpTrello.Boards in 'Lib\Boards\SpTrello.Boards.pas',
  Core.SpTrello.Lists in 'Lib\Core\Core.SpTrello.Lists.pas',
  SpTrello.Lists in 'Lib\Lists\SpTrello.Lists.pas',
  Core.SpTrello.Cards in 'Lib\Core\Core.SpTrello.Cards.pas',
  SpTrello.Cards in 'Lib\Cards\SpTrello.Cards.pas',
  Controller.Main in 'Controller\Controller.Main.pas',
  Controller.ServerModule in 'Controller\Controller.ServerModule.pas',
  Controller.MainModule in 'Controller\Controller.MainModule.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  //TServerModule.Create(Application);
  //TControllerServerModule.Create;
  TControllerServerModule.GetInstancia;
  Application.Run;
end.
