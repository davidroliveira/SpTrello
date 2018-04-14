unit Core.SpTrello.RestResponse;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  REST.Client, system.JSON, REST.Types;

type
  TCoreSpTrelloRestResponse = class(TComponent)
  private
    class var SpTrelloRestResponse: TCoreSpTrelloRestResponse;
  public
    class function Instance: TCoreSpTrelloRestResponse;
    function RestResponse: TRESTResponse;
  end;

implementation

{ TCoreSpTrelloRestResponse }

class function TCoreSpTrelloRestResponse.Instance: TCoreSpTrelloRestResponse;
begin
  if (SpTrelloRestResponse = nil) then
    SpTrelloRestResponse := TCoreSpTrelloRestResponse.Create(nil);
  Result := SpTrelloRestResponse;
end;

function TCoreSpTrelloRestResponse.RestResponse: TRESTResponse;
begin
  Result:= TRESTResponse.Create(Self);
  Result.ContentType:= 'application/json';
end;

initialization
  TCoreSpTrelloRestResponse.SpTrelloRestResponse := nil;

finalization
  if (TCoreSpTrelloRestResponse.SpTrelloRestResponse <> nil) then
    FreeAndNil(TCoreSpTrelloRestResponse.SpTrelloRestResponse);

end.

