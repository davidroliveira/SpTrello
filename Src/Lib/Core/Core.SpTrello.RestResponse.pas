unit Core.SpTrello.RestResponse;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  REST.Client, system.JSON, REST.Types;

type
  //TCoreSpTrelloRestResponse = class(TComponent)
  TCoreSpTrelloRestResponse = class
  private
    //class var SpTrelloRestResponse: TCoreSpTrelloRestResponse;
  public
    //class function Instance: TCoreSpTrelloRestResponse;
    function RestResponse: TRESTResponse;
  end;

implementation

{ TCoreSpTrelloRestResponse }

//class function TCoreSpTrelloRestResponse.Instance: TCoreSpTrelloRestResponse;
//begin
//  if (SpTrelloRestResponse = nil) then
//    SpTrelloRestResponse := TCoreSpTrelloRestResponse.Create;
//  Result := SpTrelloRestResponse;
//end;

function TCoreSpTrelloRestResponse.RestResponse: TRESTResponse;
begin
  Result:= TRESTResponse.Create(nil);
  Result.ContentType:= 'application/json';
end;

//initialization
//  TCoreSpTrelloRestResponse.SpTrelloRestResponse := nil;
//
//finalization
//  if (TCoreSpTrelloRestResponse.SpTrelloRestResponse <> nil) then
//    FreeAndNil(TCoreSpTrelloRestResponse.SpTrelloRestResponse);

end.

