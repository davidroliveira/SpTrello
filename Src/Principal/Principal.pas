unit Principal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses, UniGUIVars,
  uniGUIClasses, uniGUIRegClasses, uniGUIForm, uniGUIBaseClasses, uniButton,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, uniBasicGrid, uniDBGrid,
  SpTrello.Authenticator, SpTrello.Boards, SpTrello.Lists, SpTrello.Cards,
  uniPanel, uniPageControl, uniHTMLFrame, ServerModule, uniLabel, uniBitBtn,
  uniSpeedButton, Datasnap.DBClient;

type
  TFrmPrincipal = class(TUniForm)
    QryQuadros: TFDMemTable;
    QryLista: TFDMemTable;
    QryCards: TFDMemTable;
    UniPageControl1: TUniPageControl;
    TSGraficoSonarAutomacao: TUniTabSheet;
    LbAutomacao: TUniLabel;
    UniPanel1: TUniPanel;
    BtnAtualizarSonarAutomacao: TUniSpeedButton;
    cdsCategorias: TClientDataSet;
    cdsSeries: TClientDataSet;
    procedure UniPageControl1AjaxEvent(Sender: TComponent; EventName: string;
      Params: TUniStrings);
    procedure BtnAtualizarSonarAutomacaoClick(Sender: TObject);
    procedure UniFormCreate(Sender: TObject);
  private
    { Private declarations }
    ScriptOriginal: string;
    procedure AjusteColunasGrid(Grid: TUniDBGrid);
    procedure ConsultaDadosTrello(ExecutaRedraw: Boolean);
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses MainModule;

ResourceString
  cGRAFICOAUTOMACAO = 'automacao';

procedure TFrmPrincipal.AjusteColunasGrid(Grid: TUniDBGrid);
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

procedure TFrmPrincipal.BtnAtualizarSonarAutomacaoClick(Sender: TObject);
begin
  ConsultaDadosTrello(True);
  //UniSession.Synchronize(True);
  //UniSession.AddJS('$(' + QuotedStr('#' + cGRAFICOAUTOMACAO) + ').highcharts().redraw()');
end;

procedure TFrmPrincipal.ConsultaDadosTrello(ExecutaRedraw: Boolean);
var
  oAuthenticator: TSpTrelloAuthenticator;
  SpTrelloBoards: TSpTrelloBoards;
  SpTrelloLists: TSpTrelloLists;
  SpTrelloCards: TSpTrelloCards;
  Retorno: string;
  Categorias: string;
  Series: string;
  i: Integer;

  function ValidarCard(const ACard: string): string;
  var
    j: Integer;
    ContaInicio, ContaFim, ContaPonto: Integer;
    ParouPorErro: Boolean;
    Valido: Boolean;
    Prefixo: string;
  begin
    ContaInicio := 0;
    ContaFim := 0;
    ContaPonto := 0;
    Valido := False;
    ParouPorErro := False;
    Result := NullAsStringValue;
    Prefixo := NullAsStringValue;
    for j := 1 to ACard.Length do
    begin
      if ContaInicio < ContaFim then
      begin
        ParouPorErro := True;
        Break;
      end;

      if ACard[j] = '[' then
        Inc(ContaInicio)
      else if ACard[j] = ']' then
        Inc(ContaFim);

      if (ContaInicio = 1) and (ContaFim < 1) and (ACard[j] <> '[') then
      begin
        if ACard[j] = '.' then
          Inc(ContaPonto);

        if ContaPonto < 2 then
          Prefixo := Prefixo + ACard[j];
      end;

      if (ContaInicio = 3) and (ContaFim < 3) and (ACard[j] <> '[') then
        Result := Result + ACard[j];
    end;
    Valido := (ContaInicio = 4) and (ContaInicio = 4) and (not ParouPorErro);
    if not Valido then
      Result := NullAsStringValue
    else
      Result := '[' + Prefixo + ']-' + Result;
  end;

begin
  ScriptOriginal := Self.Script.Text;
  try
    try
      oAuthenticator := TSpTrelloAuthenticator.Create(self);
      try
        SpTrelloBoards := TSpTrelloBoards.Create(self);
        try
          SpTrelloLists := TSpTrelloLists.Create(self);
          try
            SpTrelloCards := TSpTrelloCards.Create(Self);
            oAuthenticator.User := 'davidroliveira';
            oAuthenticator.Key := '7792613d72989f58b30d11e4017ca86d';
            oAuthenticator.Token := '74fed0ced88cca018486cbf010c441bebcafdbbc55e79365fa2b4098be7d25ee';

            SpTrelloBoards.Active := False;
            SpTrelloBoards.SpTrelloAuthenticator := oAuthenticator;
            SpTrelloBoards.DataSet := QryQuadros;
            SpTrelloBoards.Active:= True;

            LbAutomacao.Caption := '<div id="' + cGRAFICOAUTOMACAO + '" style="width: 100%; height: 100%; margin: 0 auto"></div>';
            Self.Script.Text := StringReplace(Self.Script.Text, '%AUTOMACAO%', cGRAFICOAUTOMACAO, [rfIgnoreCase, rfReplaceAll]);
            Self.Script.Text := StringReplace(Self.Script.Text, '%TITULOAUTOMACAO%', SpTrelloBoards.DataSet.FieldByName('NAME').AsString, [rfIgnoreCase, rfReplaceAll]);

            if SpTrelloLists.IdBoard <> SpTrelloBoards.DataSet.FieldByName('id').AsString then
            begin
              SpTrelloLists.Active := False;
              SpTrelloLists.SpTrelloAuthenticator := oAuthenticator;
              SpTrelloLists.DataSet := QryLista;
              SpTrelloLists.IdBoard := SpTrelloBoards.DataSet.FieldByName('id').AsString;
              if (not SpTrelloBoards.DataSet.FieldByName('id').IsNull) then
                SpTrelloLists.Active := True;
            end;

            cdsCategorias.Close;
            cdsCategorias.CreateDataSet;
            cdsCategorias.EmptyDataSet;

            cdsSeries.Close;
            cdsSeries.CreateDataSet;
            cdsSeries.EmptyDataSet;

            if SpTrelloLists.Active then
            begin
              SpTrelloLists.DataSet.First;
              while not SpTrelloLists.DataSet.Eof do
              begin
                if SpTrelloCards.IdList <> SpTrelloLists.DataSet.FieldByName('id').AsString then
                begin
                  SpTrelloCards.Active := False;
                  SpTrelloCards.SpTrelloAuthenticator := oAuthenticator;
                  SpTrelloCards.DataSet := QryCards;
                  SpTrelloCards.IdList := SpTrelloLists.DataSet.FieldByName('id').AsString;
                  if (not SpTrelloLists.DataSet.FieldByName('id').IsNull) then
                    SpTrelloCards.Active := True;

                  if SpTrelloCards.Active then
                  begin
                    SpTrelloCards.DataSet.First;
                    while not SpTrelloCards.DataSet.Eof do
                    begin
                      Retorno := ValidarCard(SpTrelloCards.DataSet.FieldByName('name').AsString);
                      if Retorno <> NullAsStringValue then
                      begin
                        if cdsCategorias.Locate('name', Retorno, [loCaseInsensitive]) then
                          cdsCategorias.Edit
                        else
                          cdsCategorias.Insert;
                        cdsCategorias.FieldByName('name').AsString := Retorno;
                        cdsCategorias.FieldByName('quantidade').AsInteger := cdsCategorias.FieldByName('quantidade').AsInteger + 1;
                        cdsCategorias.Post;

                        if (SpTrelloLists.DataSet.FieldByName('id').AsString = '5a7de383069219344fe90f93') //SYNCHRONIZE
                          or (SpTrelloLists.DataSet.FieldByName('id').AsString = '5a25f68d2ef57a7ae5a6099e') then //DONE
                        begin
                          if cdsSeries.Locate('name', Retorno, [loCaseInsensitive]) then
                            cdsSeries.Edit
                          else
                            cdsSeries.Insert;
                          cdsSeries.FieldByName('name').AsString := Retorno;
                          cdsSeries.FieldByName('quantidade').AsInteger := cdsSeries.FieldByName('quantidade').AsInteger + 1;
                          cdsSeries.Post;
                        end;
                      end;
                      SpTrelloCards.DataSet.Next;
                    end;
                  end;
                end;
                SpTrelloLists.DataSet.Next;
              end;
              Categorias := NullAsStringValue;
              Series := NullAsStringValue;
              cdsCategorias.First;
              while not cdsCategorias.Eof do
              begin
                Categorias := Categorias + QuotedStr(cdsCategorias.FieldByName('name').AsString);
                if cdsCategorias.RecNo < cdsCategorias.RecordCount then
                  Categorias := Categorias + ', ';

                cdsSeries.First;
                if cdsSeries.Locate('name', cdsCategorias.FieldByName('name').AsString, [loCaseInsensitive]) then
                begin
                  FormatSettings.DecimalSeparator := '.';
                  Series := Series + FormatFloat('0.####', ((cdsSeries.FieldByName('quantidade').AsInteger / cdsCategorias.FieldByName('quantidade').AsInteger) * 100));
                  FormatSettings.DecimalSeparator := ',';
                end
                else
                  Series := Series + '0';

                if cdsCategorias.RecNo < cdsCategorias.RecordCount then
                  Series := Series + ', ';

                cdsCategorias.next;
              end;
              Self.Script.Text := StringReplace(Self.Script.Text, '%CATEGORIASAUTOMACAO%', Categorias, [rfIgnoreCase, rfReplaceAll]);
              Self.Script.Text := StringReplace(Self.Script.Text, '%DATAAUTOMACAO%', Series, [rfIgnoreCase, rfReplaceAll]);

              if ExecutaRedraw then
              begin
                UniSession.AddJS('$(' + QuotedStr('#' + cGRAFICOAUTOMACAO) + ').highcharts().series[0].setData([' + Series + '],false);');
                UniSession.AddJS('$(' + QuotedStr('#' + cGRAFICOAUTOMACAO) + ').highcharts().redraw();');
              end;
            end;
          finally
            FreeAndNil(SpTrelloCards);
          end;
        finally
          FreeAndNil(SpTrelloLists);
        end;
      finally
        FreeAndNil(SpTrelloBoards);
      end;
    finally
      FreeAndNil(oAuthenticator);
    end;
  except
    Self.Script.Clear;
    LbAutomacao.Caption := NullAsStringValue;
  end;
  cdsCategorias.Close;
  cdsSeries.Close;
end;

procedure TFrmPrincipal.UniFormCreate(Sender: TObject);
begin
  ScriptOriginal := Self.Script.Text;
  //Self.Script.Clear;
  LbAutomacao.Caption := NullAsStringValue;
  ConsultaDadosTrello(False);
end;

procedure TFrmPrincipal.UniPageControl1AjaxEvent(Sender: TComponent;
  EventName: string; Params: TUniStrings);
begin
  if EventName = 'refreshchart' then
  begin
    if LbAutomacao.Caption <> NullAsStringValue then
      UniSession.AddJS('$(' + QuotedStr('#' + cGRAFICOAUTOMACAO) + ').highcharts().reflow()');
  end;
end;

initialization
  RegisterAppFormClass(TFrmPrincipal);
end.
