unit Core.SpTrello.Base;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, System.JSON, REST.Client, IPPeerCommon, IndyPeerImpl,
  SpTrello.Authenticator, REST.Types;

type
  ICoreSpTrelloCore = interface
  ['{AB3CA4B1-39AC-408C-93A9-AB5A0D254A0A}']
    function GetEndPoint: string;
    procedure SetEndPoint(const Value: string);
    property EndPoint: string read GetEndPoint write SetEndPoint;
  end;

  TCoreSpTrelloBase = class(TInterfacedObject, ICoreSpTrelloCore)
  private
    FEndPoint: string;
    FSpAuthenticator: TSpTrelloAuthenticator;
    procedure SeTSpTrelloAuthenticator(const Value: TSpTrelloAuthenticator);
    function GetEndPoint: string;
    procedure SetEndPoint(const Value: string);
    procedure SetId(oAuthenticator: TSpTrelloAuthenticator);
  public
    constructor Create(const oAuthenticator: TSpTrelloAuthenticator); virtual;
    destructor Destroy; override;
    property EndPoint: string read GetEndPoint write SetEndPoint;
    function Request(const ARequestMethod: TRESTRequestMethod;
      const AUrl: string; const AParams: array of TJSONPair): TRESTResponse;
    property SpAuthenticator: TSpTrelloAuthenticator read FSpAuthenticator write SeTSpTrelloAuthenticator;
  end;

implementation

uses System.StrUtils, Core.SpTrello.RestClient, Core.SpTrello.RestRequest,
  Core.SpTrello.RestResponse, REST.Authenticator.OAuth, System.Threading,
  Core.SpTrello.Constants, Core.SpTrello.Authenticator, FireDAC.Comp.Client,
  Core.SpTrello.Util;

{ TCoreSpTrelloBase }

constructor TCoreSpTrelloBase.Create(const oAuthenticator: TSpTrelloAuthenticator);
begin
  inherited Create;
  if FSpAuthenticator = nil then
    //FSpAuthenticator:= TSpTrelloAuthenticator.Create(nil);
    FSpAuthenticator:= TSpTrelloAuthenticator.Create;

  FSpAuthenticator.User:= oAuthenticator.User;
  FSpAuthenticator.Key:= oAuthenticator.Key;
  FSpAuthenticator.Token:= oAuthenticator.Token;
  SetId(FSpAuthenticator);
end;

destructor TCoreSpTrelloBase.Destroy;
begin
  if FSpAuthenticator <> nil then
    FreeAndNil(FSpAuthenticator);
  inherited;
end;

function TCoreSpTrelloBase.GetEndPoint: string;
begin
  Result:= FEndPoint;
end;

function TCoreSpTrelloBase.Request(const ARequestMethod: TRESTRequestMethod;
 const AUrl: string; const AParams: array of TJSONPair): TRESTResponse;
var
  loRESTClient: TRESTClient;
  loOAuth1Authenticator: TOAuth1Authenticator;
  loRESTRequest: TRESTRequest;
begin
  Result:= nil;
  try
    loRESTClient:= TCoreSpTrelloRestClient.Instance.RestClient;
    loRESTClient.BaseURL:= AUrl;
    loOAuth1Authenticator:= TCoreSpTrelloAuthenticator.Instance.Authenticator(
      SpAuthenticator.Token, SpAuthenticator.Key, SpAuthenticator.User);
    loRESTClient.Authenticator:= loOAuth1Authenticator;
    Result:= TCoreSpTrelloRestResponse.Instance.RestResponse;
    loRESTRequest:= TCoreSpTrelloRestRequest.Instance.RestClient(AParams);
    loRESTRequest.Method:= ARequestMethod;
    loRESTRequest.Client:= loRESTClient;
    loRESTRequest.Response:= Result;
    loRESTRequest.Execute;
  except
    raise;
  end;
end;

procedure TCoreSpTrelloBase.SeTSpTrelloAuthenticator(const Value: TSpTrelloAuthenticator);
begin
  FSpAuthenticator := Value;
end;

procedure TCoreSpTrelloBase.SetEndPoint(const Value: string);
begin
  FEndPoint:= Value;
end;

procedure TCoreSpTrelloBase.SetId(oAuthenticator: TSpTrelloAuthenticator);
var
  loTable: TFDMemTable;
begin
  loTable:= TFDMemTable.Create(nil);
  try
    loTable.DataInJson(
    Request(TRESTRequestMethod.rmGET,
      Format('%s/members/%s', [TCoreSpTrelloConstants.BaseUrl, oAuthenticator.User]),
      []));
    oAuthenticator.Id:= loTable.FieldByName('id').AsString;
  finally
    FreeAndNil(loTable);
  end;
end;

end.

