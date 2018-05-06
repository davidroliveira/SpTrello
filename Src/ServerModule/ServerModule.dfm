object UniServerModule: TUniServerModule
  OldCreateOrder = False
  OnCreate = UniGUIServerModuleCreate
  TempFolder = 'temp\'
  Title = 'New Application'
  SuppressErrors = []
  Bindings = <>
  MainFormDisplayMode = mfPage
  CustomFiles.Strings = (
    
      '<script src="https://code.jquery.com/jquery-3.1.1.min.js"></scri' +
      'pt>'
    
      '<script src="https://code.highcharts.com/highcharts.js"></script' +
      '>'
    
      '<script src="https://code.highcharts.com/highcharts-more.js"></s' +
      'cript>'
    
      '<!--<script src="https://code.highcharts.com/highcharts-3d.js"><' +
      '/script>-->'
    
      '<!--<script src="https://code.highcharts.com/modules/exporting.j' +
      's"></script>'#9'-->'
    
      '<!--<script src="https://code.highcharts.com/modules/export-data' +
      '.js"></script>-->')
  SSL.SSLOptions.RootCertFile = 'root.pem'
  SSL.SSLOptions.CertFile = 'cert.pem'
  SSL.SSLOptions.KeyFile = 'key.pem'
  SSL.SSLOptions.Method = sslvTLSv1_1
  SSL.SSLOptions.SSLVersions = [sslvTLSv1_1]
  SSL.SSLOptions.Mode = sslmUnassigned
  SSL.SSLOptions.VerifyMode = []
  SSL.SSLOptions.VerifyDepth = 0
  Options = [soAutoPlatformSwitch, soRestartSessionOnTimeout, soWipeShadowSessions]
  ConnectionFailureRecovery.DetailedLog = True
  ConnectionFailureRecovery.FullSequenceLog = True
  ConnectionFailureRecovery.ErrorMessage = 'Connection Error'
  ConnectionFailureRecovery.RetryMessage = 'Retrying...'
  Height = 150
  Width = 215
end
