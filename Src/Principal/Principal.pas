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
  uniSpeedButton, uniTimer;

type
  TFrmPrincipal = class(TUniForm)
    QryQuadros: TFDMemTable;
    QryLista: TFDMemTable;
    QryCards: TFDMemTable;
    UniPageControl1: TUniPageControl;
    TSGraficoSPTrelloAutomacao: TUniTabSheet;
    LbAutomacao: TUniLabel;
    UniTimer: TUniTimer;
    TblCategorias: TFDMemTable;
    TblSeries: TFDMemTable;
    LbTotalCards: TUniLabel;
    UniPanel3: TUniPanel;
    UniLabel3: TUniLabel;
    UniPanel4: TUniPanel;
    LbPercentual: TUniLabel;
    UniLabel5: TUniLabel;
    UniPanel5: TUniPanel;
    UniPanel6: TUniPanel;
    UniPanel7: TUniPanel;
    UniPanel8: TUniPanel;
    procedure UniPageControl1AjaxEvent(Sender: TComponent; EventName: string;
      Params: TUniStrings);
    procedure UniFormCreate(Sender: TObject);
    procedure UniTimerTimer(Sender: TObject);
  private
    { Private declarations }
    ScriptOriginal: string;
    procedure ConsultaDadosTrello(ExecutaRedraw: Boolean);
    procedure TrimAppMemorySize;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses MainModule;

ResourceString
  cGRAFICOAUTOMACAO = 'automacao';

procedure TFrmPrincipal.TrimAppMemorySize;
var
  MainHandle : THandle;
begin
  try
    MainHandle := OpenProcess(PROCESS_ALL_ACCESS, false, GetCurrentProcessID) ;
    SetProcessWorkingSetSize(MainHandle, $FFFFFFFF, $FFFFFFFF) ;
    CloseHandle(MainHandle) ;
  except
  end;
  Application.ProcessMessages;
end;

procedure TFrmPrincipal.ConsultaDadosTrello(ExecutaRedraw: Boolean);
var
  oAuthenticator: TSpTrelloAuthenticator;
  SpTrelloBoards: TSpTrelloBoards;
  SpTrelloLists: TSpTrelloLists;
  SpTrelloCards: TSpTrelloCards;
  Retorno: string;
  RetornoID: Integer;
  Categorias: string;
  Series: string;
  OldScript: string;
  QuantidadeTotal: integer;
  QuantidadeImplementado: integer;

  procedure ValidarCard(const ACard: string; out IdCard: Integer; out NameCard: string);
  var
    j: Integer;
    ContaInicio, ContaFim, ContaPonto: Integer;
    ParouPorErro: Boolean;
    Valido: Boolean;
    Prefixo: string;
    SubPrefixo: string;
    SubNomeCard: string;
  begin
    ContaInicio := 0;
    ContaFim := 0;
    ContaPonto := 0;
    Valido := False;
    ParouPorErro := False;
    NameCard := NullAsStringValue;
    IdCard := 0;
    Prefixo := NullAsStringValue;
    SubPrefixo := NullAsStringValue;
    SubNomeCard := NullAsStringValue;
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

        if ContaPonto < 1 then
          Prefixo := Prefixo + ACard[j];
      end;

      if (ContaInicio = 2) and (ContaFim < 2) and (ACard[j] <> '[') then
        NameCard := NameCard + ACard[j];
    end;
    Valido := (ContaInicio in [3,4,6]) and (ContaFim = ContaInicio) and (not ParouPorErro);
    if not Valido then
      NameCard := NullAsStringValue
    else
    begin
      if Prefixo = '1' then
      begin
        SubPrefixo := ACard;
        SubPrefixo := Copy(SubPrefixo, Pos('[1.', SubPrefixo) + 3, Length(SubPrefixo));
        SubPrefixo := Copy(SubPrefixo, 1, Pos('.', SubPrefixo)-1);

        SubNomeCard := ACard;
        SubNomeCard := Copy(SubNomeCard, Pos('[', SubNomeCard) + 1, Length(SubNomeCard));
        SubNomeCard := Copy(SubNomeCard, Pos('[', SubNomeCard) + 1, Length(SubNomeCard));
        SubNomeCard := Copy(SubNomeCard, Pos('[', SubNomeCard) + 1, Length(SubNomeCard));
        SubNomeCard := Copy(SubNomeCard, 1, Pos(']', SubNomeCard) - 1);

        IdCard := (StrToInt(Prefixo) * 10000) + StrToInt(SubPrefixo);
        NameCard := '[' + Prefixo + '.' + SubPrefixo + ']-[' + SubNomeCard + ']';
      end
      else
      begin
        IdCard := StrToInt(Prefixo) * 10000;
        NameCard := '[' + Prefixo + ']-[' + NameCard + ']';
      end;
    end;
  end;

begin
  UniTimer.Enabled := False;
  OldScript := Self.Script.Text;
  Self.Script.Text := ScriptOriginal;
  try
    TblCategorias.IndexFieldNames := 'id';
    TblCategorias.Open;
    try
      TblSeries.Open;
      TblSeries.IndexFieldNames := 'name;lista';
      try
        oAuthenticator := TSpTrelloAuthenticator.Create;
        try
          oAuthenticator.User := 'davidroliveira';
          oAuthenticator.Key := '7792613d72989f58b30d11e4017ca86d';
          oAuthenticator.Token := '74fed0ced88cca018486cbf010c441bebcafdbbc55e79365fa2b4098be7d25ee';
          SpTrelloBoards := TSpTrelloBoards.Create;
          try
            SpTrelloLists := TSpTrelloLists.Create;
            try
              SpTrelloCards := TSpTrelloCards.Create;
              try
                if QryQuadros.Active then
                  QryQuadros.EmptyDataSet;
                QryQuadros.Close;
                SpTrelloBoards.Active := False;
                SpTrelloBoards.SpTrelloAuthenticator := oAuthenticator;
                SpTrelloBoards.DataSet := QryQuadros;
                SpTrelloBoards.Active := True;

                LbAutomacao.Caption := '<div id="' + cGRAFICOAUTOMACAO + '" style="width: 100%; height: 100%; margin: 0 auto"></div>';
                Self.Script.Text := StringReplace(Self.Script.Text, '%AUTOMACAO%', cGRAFICOAUTOMACAO, [rfIgnoreCase, rfReplaceAll]);
                Self.Script.Text := StringReplace(Self.Script.Text, '%TITULOAUTOMACAO%', 'Quadro ' + SpTrelloBoards.DataSet.FieldByName('NAME').AsString, [rfIgnoreCase, rfReplaceAll]);

                if SpTrelloLists.IdBoard <> SpTrelloBoards.DataSet.FieldByName('id').AsString then
                begin
                  if QryLista.Active then
                    QryLista.EmptyDataSet;
                  QryLista.Close;
                  SpTrelloLists.Active := False;
                  SpTrelloLists.SpTrelloAuthenticator := oAuthenticator;
                  SpTrelloLists.DataSet := QryLista;
                  SpTrelloLists.IdBoard := SpTrelloBoards.DataSet.FieldByName('id').AsString;
                  if (not SpTrelloBoards.DataSet.FieldByName('id').IsNull) then
                    SpTrelloLists.Active := True;
                end;

                TblCategorias.Close;
                TblCategorias.Open;
                TblCategorias.EmptyDataSet;

                TblSeries.Close;
                TblSeries.Open;
                TblSeries.EmptyDataSet;

                if SpTrelloLists.Active and SpTrelloLists.DataSet.Active then
                begin
                  SpTrelloLists.DataSet.First;
                  while not SpTrelloLists.DataSet.Eof do
                  begin
                    if SpTrelloCards.IdList <> SpTrelloLists.DataSet.FieldByName('id').AsString then
                    begin
                      if QryCards.Active then
                        QryCards.IsEmpty;
                      QryCards.Close;
                      SpTrelloCards.Active := False;
                      SpTrelloCards.SpTrelloAuthenticator := oAuthenticator;
                      SpTrelloCards.DataSet := QryCards;
                      SpTrelloCards.IdList := SpTrelloLists.DataSet.FieldByName('id').AsString;
                      if (not SpTrelloLists.DataSet.FieldByName('id').IsNull) then
                        SpTrelloCards.Active := True;

                      if SpTrelloCards.Active and SpTrelloCards.DataSet.Active then
                      begin
                        SpTrelloCards.DataSet.First;
                        while not SpTrelloCards.DataSet.Eof do
                        begin
                          ValidarCard(SpTrelloCards.DataSet.FieldByName('name').AsString, RetornoID, Retorno);
                          if Retorno <> NullAsStringValue then
                          begin
                            if TblCategorias.Locate('name', Retorno, [loCaseInsensitive]) then
                              TblCategorias.Edit
                            else
                              TblCategorias.Insert;
                            TblCategorias.FieldByName('id').AsInteger := RetornoID;
                            TblCategorias.FieldByName('name').AsString := Retorno;
                            TblCategorias.FieldByName('quantidade').AsInteger := TblCategorias.FieldByName('quantidade').AsInteger + 1;
                            TblCategorias.Post;

                            if (SpTrelloLists.DataSet.FieldByName('id').AsString = '5a7de383069219344fe90f93') //SYNCHRONIZE
                              or (SpTrelloLists.DataSet.FieldByName('id').AsString = '5a25f68d2ef57a7ae5a6099e') then //DONE
                            begin
                              if TblSeries.Locate('name', Retorno, [loCaseInsensitive]) then
                                TblSeries.Edit
                              else
                                TblSeries.Insert;
                              TblSeries.FieldByName('name').AsString := Retorno;
                              TblSeries.FieldByName('quantidade').AsInteger := TblSeries.FieldByName('quantidade').AsInteger + 1;
                              TblSeries.Post;
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
                  QuantidadeTotal := 0;
                  QuantidadeImplementado := 0;
                  TblCategorias.First;
                  while not TblCategorias.Eof do
                  begin
                    TblSeries.First;
                    if TblSeries.Locate('name', TblCategorias.FieldByName('name').AsString, [loCaseInsensitive]) then
                    begin
                      FormatSettings.DecimalSeparator := '.';
                      Series := Series + '{name: ' + QuotedStr(TblCategorias.FieldByName('name').AsString +
                      //Series := Series + '{name: ' + QuotedStr('<span style="white-space: nowrap;">' + TblCategorias.FieldByName('name').AsString + '</span>' +
                        ' Cards: ' + FormatFloat('0', TblSeries.FieldByName('quantidade').AsInteger) + '/' + FormatFloat('0', TblCategorias.FieldByName('quantidade').AsInteger)) +
                        ', y: ' + FormatFloat('0.####', ((TblSeries.FieldByName('quantidade').AsInteger / TblCategorias.FieldByName('quantidade').AsInteger) * 100)) + '}';
                      FormatSettings.DecimalSeparator := ',';
                      QuantidadeImplementado := QuantidadeImplementado + TblSeries.FieldByName('quantidade').AsInteger;
                    end
                    else
                    begin
                      Series := Series + '{name: ' + QuotedStr(TblCategorias.FieldByName('name').AsString +
                      //Series := Series + '{name: ' + QuotedStr('<span style="white-space: nowrap;">' + TblCategorias.FieldByName('name').AsString + '</span>' +
                        ' Cards: 0/' + FormatFloat('0', TblCategorias.FieldByName('quantidade').AsInteger)) +
                        ', y: 0}';
                    end;
                    QuantidadeTotal := QuantidadeTotal + TblCategorias.FieldByName('quantidade').AsInteger;
                    if TblCategorias.RecNo < TblCategorias.RecordCount then
                      Series := Series + ', ';

                    Categorias := Categorias + QuotedStr(TblCategorias.FieldByName('name').AsString);
                    //Categorias := Categorias + QuotedStr('<span style="white-space: nowrap;">' + TblCategorias.FieldByName('name').AsString + '</span>');
                    if TblCategorias.RecNo < TblCategorias.RecordCount then
                      Categorias := Categorias + ', ';

                    TblCategorias.next;
                  end;

                  LbTotalCards.Caption := IntToStr(QuantidadeImplementado) + '/' + IntToStr(QuantidadeTotal);
                  LbPercentual.Caption := FormatFloat('0', (QuantidadeImplementado / QuantidadeTotal) * 100) + '%';
                  Self.Script.Text := StringReplace(Self.Script.Text, '%CATEGORIASAUTOMACAO%', Categorias, [rfIgnoreCase, rfReplaceAll]);
                  Self.Script.Text := StringReplace(Self.Script.Text, '%DATAAUTOMACAO%', Series, [rfIgnoreCase, rfReplaceAll]);

                  //Series.SaveToFile(UniServerModule.LocalCachePath + '\dados.csv');
                  //Series.Text := '[' + Trim(Series.Text) + ']';
                  //Series.SaveToFile(UniServerModule.LocalCachePath + '\dados.json');

                  //Self.Script.Text := StringReplace(Self.Script.Text, '%DATAAUTOMACAO%', UniServerModule.LocalCacheURL + 'dados.json', [rfIgnoreCase, rfReplaceAll]);
                  //Self.Script.SaveToFile('c:\teste.txt');

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
      finally
        //TblSeries.EmptyDataSet;
        //TblSeries.Close;
      end;
    finally
      //TblCategorias.EmptyDataSet;
      //TblCategorias.Close;
    end;
  except
    Self.Script.Text := OldScript;
  end;
  QryQuadros.Close;
  QryLista.Close;
  QryCards.Close;
  UniTimer.Enabled := True;
//  TrimAppMemorySize;
end;

procedure TFrmPrincipal.UniFormCreate(Sender: TObject);
begin
  ScriptOriginal := Self.Script.Text;
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

procedure TFrmPrincipal.UniTimerTimer(Sender: TObject);
begin
  ConsultaDadosTrello(True);
end;

initialization
  RegisterAppFormClass(TFrmPrincipal);
end.
