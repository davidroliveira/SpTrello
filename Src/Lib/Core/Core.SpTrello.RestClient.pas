unit Core.SpTrello.RestClient;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  REST.Client;

type
  TCoreSpTrelloRestClient = class(TComponent)
  private
    class var SpTrelloRestClient: TCoreSpTrelloRestClient;
  public
    class function Instance: TCoreSpTrelloRestClient;
    function RestClient: TRESTClient;
  end;

implementation

{ TCoreSpTrelloRestClient }

class function TCoreSpTrelloRestClient.Instance: TCoreSpTrelloRestClient;
begin
  if (SpTrelloRestClient = nil) then
    SpTrelloRestClient := TCoreSpTrelloRestClient.Create(nil);
  Result := SpTrelloRestClient;
end;

function TCoreSpTrelloRestClient.RestClient: TRESTClient;
begin
  Result:= TRESTClient.Create(self);
  Result.Accept:= 'application/json, text/plain; q=0.9, text/html;q=0.8,';
  Result.AcceptCharset:= 'UTF-8, *;q=0.8';
  Result.HandleRedirects:= True;
  Result.RaiseExceptionOn500:= False;
end;

initialization
  TCoreSpTrelloRestClient.SpTrelloRestClient := nil;

finalization
  if (TCoreSpTrelloRestClient.SpTrelloRestClient <> nil) then
    FreeAndNil(TCoreSpTrelloRestClient.SpTrelloRestClient);

end.

