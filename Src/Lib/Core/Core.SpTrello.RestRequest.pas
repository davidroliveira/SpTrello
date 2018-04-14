unit Core.SpTrello.RestRequest;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  REST.Client, system.JSON, REST.Types;

type
  TCoreSpTrelloRestRequest = class(TComponent)
  private
    class var SpTrelloRestRequest: TCoreSpTrelloRestRequest;
  public
    destructor Destroy; override;
    class function Instance: TCoreSpTrelloRestRequest;
    function RestClient(const AParams: array of TJSONPair): TRESTRequest;
  end;

implementation

{ TCoreSpTrelloRestRequest }

destructor TCoreSpTrelloRestRequest.Destroy;
begin
  inherited;
end;

class function TCoreSpTrelloRestRequest.Instance: TCoreSpTrelloRestRequest;
begin
  if (SpTrelloRestRequest = nil) then
    SpTrelloRestRequest := TCoreSpTrelloRestRequest.Create(nil);
  Result := SpTrelloRestRequest;
end;

function TCoreSpTrelloRestRequest.RestClient(
  const AParams: array of TJSONPair): TRESTRequest;
var
  nContador: Integer;
begin
  Result:= TRESTRequest.Create(Self);
  Result.SynchronizedEvents:= False;
  for nContador := 0 to High(AParams) do
  begin
    Result.AddParameter(StringReplace(AParams[nContador].JsonString.ToString, '"','', [rfReplaceAll, rfIgnoreCase]),
      StringReplace(AParams[nContador].JsonValue.ToString, '"', '', [rfReplaceAll, rfIgnoreCase]));
  end;

  for nContador := High(AParams) downto 0 do
    AParams[nContador].Free;
end;

initialization
  TCoreSpTrelloRestRequest.SpTrelloRestRequest := nil;

finalization
  if (TCoreSpTrelloRestRequest.SpTrelloRestRequest <> nil) then
    FreeAndNil(TCoreSpTrelloRestRequest.SpTrelloRestRequest);

end.

