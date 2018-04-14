unit Core.SpTrello.Authenticator;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  REST.Authenticator.OAuth;

type
  TCoreSpTrelloOAuth1Authenticator = class(TOAuth1Authenticator)
  strict private
    FAccessUser: string;
    procedure SetAccessUser(const Value: string);
  public
    property AccessUser: string read FAccessUser write SetAccessUser;
  end;

  TCoreSpTrelloAuthenticator = class(TComponent)
  private
    class var SpTrelloAuthenticator: TCoreSpTrelloAuthenticator;
  public
    class function Instance: TCoreSpTrelloAuthenticator;
    function Authenticator(const psAccessToken, psConsumerKey,
      psAccessUser: string): TCoreSpTrelloOAuth1Authenticator;
  end;

implementation

{ TCoreSpTrelloAuthenticator }

function TCoreSpTrelloAuthenticator.authenticator(const psAccessToken,
  psConsumerKey, psAccessUser: string): TCoreSpTrelloOAuth1Authenticator;
begin
  Result:= TCoreSpTrelloOAuth1Authenticator.Create(Self);
  Result.AccessToken:= psAccessToken;
  Result.ConsumerKey:= psConsumerKey;
  Result.AccessUser:= psAccessUser;
end;

class function TCoreSpTrelloAuthenticator.Instance: TCoreSpTrelloAuthenticator;
begin
  if (SpTrelloAuthenticator = nil) then
    SpTrelloAuthenticator := TCoreSpTrelloAuthenticator.Create(nil);
  Result := SpTrelloAuthenticator;
end;

{ TCoreSpTrelloOAuth1Authenticator }

procedure TCoreSpTrelloOAuth1Authenticator.SetAccessUser(const Value: string);
begin
  FAccessUser := Value;
end;

initialization
  TCoreSpTrelloAuthenticator.SpTrelloAuthenticator := nil;

finalization
  if (TCoreSpTrelloAuthenticator.SpTrelloAuthenticator <> nil) then
    FreeAndNil(TCoreSpTrelloAuthenticator.SpTrelloAuthenticator);

end.

