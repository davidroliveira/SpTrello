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
  FSpAuthenticator := oAuthenticator;
  SetId(FSpAuthenticator);
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

  CoreSpTrelloRestClient: TCoreSpTrelloRestClient;
  CoreSpTrelloAuthenticator: TCoreSpTrelloAuthenticator;
  CoreSpTrelloRestResponse: TCoreSpTrelloRestResponse;
  CoreSpTrelloRestRequest: TCoreSpTrelloRestRequest;
begin
  Result:= nil;
  try
    CoreSpTrelloRestClient := TCoreSpTrelloRestClient.Create;
    try
      loRESTClient := CoreSpTrelloRestClient.RestClient;
      try
        //loRESTClient := TCoreSpTrelloRestClient.Instance.RestClient;
        loRESTClient.BaseURL := AUrl;

        //loOAuth1Authenticator := TCoreSpTrelloAuthenticator.Instance.Authenticator(SpAuthenticator.Token, SpAuthenticator.Key, SpAuthenticator.User);
        CoreSpTrelloAuthenticator := TCoreSpTrelloAuthenticator.Create;
        try
          loOAuth1Authenticator := CoreSpTrelloAuthenticator.Authenticator(SpAuthenticator.Token, SpAuthenticator.Key, SpAuthenticator.User);
          try
            loRESTClient.Authenticator := loOAuth1Authenticator;

            CoreSpTrelloRestResponse := TCoreSpTrelloRestResponse.Create;
            try
              //Result := TCoreSpTrelloRestResponse.Instance.RestResponse;
              Result := CoreSpTrelloRestResponse.RestResponse;

              CoreSpTrelloRestRequest := TCoreSpTrelloRestRequest.Create;
              try
                //loRESTRequest := TCoreSpTrelloRestRequest.Instance.RestClient(AParams);
                loRESTRequest := CoreSpTrelloRestRequest.RestClient(AParams);
                loRESTRequest.Method := ARequestMethod;
                loRESTRequest.Client := loRESTClient;
                loRESTRequest.Response := Result;
                loRESTRequest.Execute;
              finally
                FreeAndNil(CoreSpTrelloRestRequest);
              end;
            finally
              FreeAndNil(CoreSpTrelloRestResponse);
            end;
          finally
            FreeAndNil(loOAuth1Authenticator);
          end;
        finally
          FreeAndNil(CoreSpTrelloAuthenticator);
        end;
      finally
        FreeAndNil(loRESTClient);
      end;
    finally
      FreeAndNil(CoreSpTrelloRestClient);
    end;
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

