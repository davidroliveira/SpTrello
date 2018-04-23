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
  uniSpeedButton, Datasnap.DBClient, uniTimer;

type
  TFrmPrincipal = class(TUniForm)
    QryQuadros: TFDMemTable;
    QryLista: TFDMemTable;
    QryCards: TFDMemTable;
    UniPageControl1: TUniPageControl;
    TSGraficoSPTrelloAutomacao: TUniTabSheet;
    LbAutomacao: TUniLabel;
    UniPanel1: TUniPanel;
    UniTimer: TUniTimer;
    procedure UniPageControl1AjaxEvent(Sender: TComponent; EventName: string;
      Params: TUniStrings);
    procedure UniFormCreate(Sender: TObject);
    procedure UniTimerTimer(Sender: TObject);
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
  cdsCategorias: TClientDataSet;
  cdsSeries: TClientDataSet;

  procedure ValidarCard(const ACard: string; out IdCard: Integer; out NameCard: string);
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
    NameCard := NullAsStringValue;
    IdCard := 0;
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

        //if ContaPonto < 2 then
        if ContaPonto < 1 then
          Prefixo := Prefixo + ACard[j];
      end;

      //if (ContaInicio = 3) and (ContaFim < 3) and (ACard[j] <> '[') then
      if (ContaInicio = 2) and (ContaFim < 2) and (ACard[j] <> '[') then
        NameCard := NameCard + ACard[j];
    end;
    Valido := (ContaInicio in [3,4,6]) and (ContaFim = ContaInicio) and (not ParouPorErro);
    if not Valido then
      NameCard := NullAsStringValue
    else
    begin
      IdCard := StrToInt(Prefixo);
      NameCard := '[' + Prefixo + ']-' + NameCard;
    end;
  end;

begin
  //LbAutomacao.Caption :=
  //ScriptOriginal := Self.Script.Text;
  UniTimer.Enabled := False;
  OldScript := Self.Script.Text;
  Self.Script.Text := ScriptOriginal;
  try
    cdsCategorias := TClientDataSet.Create(Self);
    try
      cdsCategorias.IndexFieldNames := 'id';
      with cdsCategorias.FieldDefs.AddFieldDef do
      begin
        Name := 'id';
        DataType := ftInteger;
      end;
      with cdsCategorias.FieldDefs.AddFieldDef do
      begin
        Name := 'name';
        DataType := ftString;
        Size := 1000;
      end;
      with cdsCategorias.FieldDefs.AddFieldDef do
      begin
        Name := 'quantidade';
        DataType := ftInteger;
      end;

      cdsCategorias.CreateDataSet;
      cdsCategorias.Open;
      cdsSeries := TClientDataSet.Create(Self);
      try
        with cdsSeries.FieldDefs.AddFieldDef do
        begin
          Name := 'name';
          DataType := ftString;
          Size := 1000;
        end;

        with cdsSeries.FieldDefs.AddFieldDef do
        begin
          Name := 'lista';
          DataType := ftString;
          Size := 1000;
        end;

        with cdsSeries.FieldDefs.AddFieldDef do
        begin
          Name := 'quantidade';
          DataType := ftInteger;
        end;

        cdsSeries.CreateDataSet;
        cdsSeries.Open;
        try
          cdsSeries.IndexFieldNames := 'name;lista';
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

                QryQuadros.Close;
                SpTrelloBoards.Active := False;
                SpTrelloBoards.SpTrelloAuthenticator := oAuthenticator;
                SpTrelloBoards.DataSet := QryQuadros;
                SpTrelloBoards.Active:= True;

                LbAutomacao.Caption := '<div id="' + cGRAFICOAUTOMACAO + '" style="width: 100%; height: 100%; margin: 0 auto"></div>';
                Self.Script.Text := StringReplace(Self.Script.Text, '%AUTOMACAO%', cGRAFICOAUTOMACAO, [rfIgnoreCase, rfReplaceAll]);
                Self.Script.Text := StringReplace(Self.Script.Text, '%TITULOAUTOMACAO%', SpTrelloBoards.DataSet.FieldByName('NAME').AsString, [rfIgnoreCase, rfReplaceAll]);

                if SpTrelloLists.IdBoard <> SpTrelloBoards.DataSet.FieldByName('id').AsString then
                begin
                  QryLista.Close;
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

                if SpTrelloLists.Active and SpTrelloLists.DataSet.Active then
                begin
                  SpTrelloLists.DataSet.First;
                  while not SpTrelloLists.DataSet.Eof do
                  begin
                    if SpTrelloCards.IdList <> SpTrelloLists.DataSet.FieldByName('id').AsString then
                    begin
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
                          //Retorno := ValidarCard(SpTrelloCards.DataSet.FieldByName('name').AsString);
                          ValidarCard(SpTrelloCards.DataSet.FieldByName('name').AsString, RetornoID, Retorno);
                          if Retorno <> NullAsStringValue then
                          begin
                            if cdsCategorias.Locate('name', Retorno, [loCaseInsensitive]) then
                              cdsCategorias.Edit
                            else
                              cdsCategorias.Insert;
                            cdsCategorias.FieldByName('id').AsInteger := RetornoID;
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
    //                Categorias := Categorias + QuotedStr(cdsCategorias.FieldByName('name').AsString);
    //                if cdsCategorias.RecNo < cdsCategorias.RecordCount then
    //                  Categorias := Categorias + ', ';

                    cdsSeries.First;
                    if cdsSeries.Locate('name', cdsCategorias.FieldByName('name').AsString, [loCaseInsensitive]) then
                    begin
                      FormatSettings.DecimalSeparator := '.';
                      Series := Series + '{name: ' + QuotedStr(cdsCategorias.FieldByName('name').AsString +
                        ' Cards: ' + FormatFloat('0', cdsSeries.FieldByName('quantidade').AsInteger) + '/' + FormatFloat('0', cdsCategorias.FieldByName('quantidade').AsInteger)) +
                        ', y: ' + FormatFloat('0.####', ((cdsSeries.FieldByName('quantidade').AsInteger / cdsCategorias.FieldByName('quantidade').AsInteger) * 100)) + '}';
                      //Series := Series + FormatFloat('0.####', ((cdsSeries.FieldByName('quantidade').AsInteger / cdsCategorias.FieldByName('quantidade').AsInteger) * 100));
                      FormatSettings.DecimalSeparator := ',';
                    end
                    else
                      Series := Series + '0';

                    if cdsCategorias.RecNo < cdsCategorias.RecordCount then
                      Series := Series + ', ';

                    Categorias := Categorias + QuotedStr(cdsCategorias.FieldByName('name').AsString);
                    //Categorias := Categorias + QuotedStr('<div style="white-space: nowrap;text-align:left">' + cdsCategorias.FieldByName('name').AsString + '</div>');
                    //'<div style="background-color:#00BFFF;text-align:center">'
                    if cdsCategorias.RecNo < cdsCategorias.RecordCount then
                      Categorias := Categorias + ', ';

                    cdsCategorias.next;
                  end;
                  //exit;
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
        cdsSeries.EmptyDataSet;
        cdsSeries.Close;
      finally
        FreeAndNil(cdsSeries);
      end;
      cdsCategorias.EmptyDataSet;
      cdsCategorias.Close;
    finally
      FreeAndNil(cdsCategorias);
    end;
  except
    //Self.Script.Clear;
    Self.Script.Text := OldScript;
    //LbAutomacao.Caption := NullAsStringValue;
  end;
  QryQuadros.Close;
  QryLista.Close;
  QryCards.Close;
  UniTimer.Enabled := True;
//  cdsCategorias.Close;
//  cdsSeries.Close;
end;

procedure TFrmPrincipal.UniFormCreate(Sender: TObject);
begin
  ScriptOriginal := Self.Script.Text;
  //Self.Script.Text := StringReplace(Self.Script.Text, '%CATEGORIASAUTOMACAO%', 'teste,teste', [rfIgnoreCase, rfReplaceAll]);
  //Self.Script.Text := StringReplace(Self.Script.Text, '%DATAAUTOMACAO%', UniServerModule.LocalCacheURL + 'dados.json', [rfIgnoreCase, rfReplaceAll]);
  //Self.Script.Clear;
  //LbAutomacao.Caption := NullAsStringValue;
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
