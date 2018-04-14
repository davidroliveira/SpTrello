unit View.Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIRegClasses, uniGUIForm, uniGUIBaseClasses, uniButton,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, uniBasicGrid, uniDBGrid,
  SpTrello.Authenticator, SpTrello.Boards, SpTrello.Lists, SpTrello.Cards,
  uniPanel, uniPageControl, uniHTMLFrame, View.ServerModule, uniLabel;

type
  TMain = class(TUniForm)
    QryQuadros: TFDMemTable;
    DSQuadros: TDataSource;
    GridQuadros: TUniDBGrid;
    UniButton2: TUniButton;
    GridLista: TUniDBGrid;
    QryLista: TFDMemTable;
    DSLista: TDataSource;
    QryCards: TFDMemTable;
    DSCards: TDataSource;
    GridCards: TUniDBGrid;
    UniPageControl1: TUniPageControl;
    UniTabSheet1: TUniTabSheet;
    UniTabSheet2: TUniTabSheet;
    UniLabel1: TUniLabel;
    procedure UniButton2Click(Sender: TObject);
    procedure UniFormCreate(Sender: TObject);
    procedure UniFormDestroy(Sender: TObject);
    procedure QryQuadrosAfterScroll(DataSet: TDataSet);
    procedure QryListaAfterScroll(DataSet: TDataSet);
    procedure UniPageControl1AjaxEvent(Sender: TComponent; EventName: string;
      Params: TUniStrings);
  private
    { Private declarations }
    oAuthenticator: TSpTrelloAuthenticator;
    SpTrelloBoards: TSpTrelloBoards;
    SpTrelloLists: TSpTrelloLists;
    SpTrelloCards: TSpTrelloCards;
    procedure AjusteColunasGrid(Grid: TUniDBGrid);
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses View.MainModule;

procedure TMain.AjusteColunasGrid(Grid: TUniDBGrid);
var
  i: Integer;
begin
  for I := 0 to Grid.Columns.Count - 1 do
  begin
    if AnsiUpperCase(Grid.Columns[i].FieldName) = 'NAME' then
      Grid.Columns[i].Width := 100
    else
      Grid.Columns[i].Width := 70;
  end;
end;

procedure TMain.QryListaAfterScroll(DataSet: TDataSet);
begin
  if SpTrelloCards.IdList <> SpTrelloLists.DataSet.FieldByName('id').AsString then
  begin
    SpTrelloCards.Active := False;
    SpTrelloCards.SpTrelloAuthenticator := oAuthenticator;
    SpTrelloCards.DataSet := QryCards;
    SpTrelloCards.IdList := SpTrelloLists.DataSet.FieldByName('id').AsString;
    if (not SpTrelloLists.DataSet.FieldByName('id').IsNull) then
      SpTrelloCards.Active := True;
  end;
  AjusteColunasGrid(GridCards);
end;

procedure TMain.QryQuadrosAfterScroll(DataSet: TDataSet);
begin
  if SpTrelloLists.IdBoard <> SpTrelloBoards.DataSet.FieldByName('id').AsString then
  begin
    SpTrelloLists.Active := False;
    SpTrelloLists.SpTrelloAuthenticator := oAuthenticator;
    SpTrelloLists.DataSet := QryLista;
    SpTrelloLists.IdBoard := SpTrelloBoards.DataSet.FieldByName('id').AsString;
    if (not SpTrelloBoards.DataSet.FieldByName('id').IsNull) then
      SpTrelloLists.Active := True;
  end;
  AjusteColunasGrid(GridLista);
end;

procedure TMain.UniButton2Click(Sender: TObject);
begin
  oAuthenticator.User := 'davidroliveira';
  oAuthenticator.Key := '7792613d72989f58b30d11e4017ca86d';
  oAuthenticator.Token := '74fed0ced88cca018486cbf010c441bebcafdbbc55e79365fa2b4098be7d25ee';

  SpTrelloBoards.Active := False;
  SpTrelloBoards.SpTrelloAuthenticator := oAuthenticator;
  SpTrelloBoards.DataSet := QryQuadros;
  SpTrelloBoards.Active:= True;
  AjusteColunasGrid(GridQuadros);
end;

procedure TMain.UniFormCreate(Sender: TObject);
begin
  oAuthenticator := TSpTrelloAuthenticator.Create(self);
  SpTrelloBoards := TSpTrelloBoards.Create(self);
  SpTrelloLists := TSpTrelloLists.Create(self);
  SpTrelloCards := TSpTrelloCards.Create(Self);
end;

procedure TMain.UniFormDestroy(Sender: TObject);
begin
  FreeAndNil(SpTrelloCards);
  FreeAndNil(SpTrelloLists);
  FreeAndNil(SpTrelloBoards);
  FreeAndNil(oAuthenticator);
end;

procedure TMain.UniPageControl1AjaxEvent(Sender: TComponent;
  EventName: string; Params: TUniStrings);
begin
  if EventName = 'resize' then
    UniSession.AddJS('$(''#container'').highcharts().reflow()');

end;

end.
