object FrmPrincipal: TFrmPrincipal
  Left = 0
  Top = 0
  ClientHeight = 640
  ClientWidth = 709
  Caption = 'FrmPrincipal'
  OldCreateOrder = False
  Script.Strings = (
    '$(function () {'
    ''
    '    Highcharts.theme = {'
    
      '        colors: ["#2b908f", "#90ee7e", "#f45b5b", "#7798BF", "#a' +
      'aeeee", "#ff0066", "#eeaaee",'
    '            "#55BF3B", "#DF5353", "#7798BF", "#aaeeee"],'
    '        chart: {'
    '            backgroundColor: {'
    '                linearGradient: {'
    '                    x1: 0,'
    '                    y1: 0,'
    '                    x2: 1,'
    '                    y2: 1'
    '                },'
    '                stops: ['
    '                    [0, '#39'#2a2a2b'#39'],'
    '                    [1, '#39'#3e3e40'#39']'
    '                ]'
    '            },'
    '            style: {'
    '                fontFamily: "'#39'Unica One'#39', sans-serif"'
    '            },'
    '            plotBorderColor: '#39'#606063'#39
    '        },'
    '        title: {'
    '            style: {'
    '                color: '#39'#E0E0E3'#39','
    '                textTransform: '#39'uppercase'#39','
    '                fontSize: '#39'20px'#39
    '            }'
    '        },'
    '        subtitle: {'
    '            style: {'
    '                color: '#39'#E0E0E3'#39','
    '                textTransform: '#39'uppercase'#39
    '            }'
    '        },'
    '        xAxis: {'
    '            gridLineColor: '#39'#707073'#39','
    '            labels: {                '
    '                //useHTML: true,'
    '                style: {'
    '                    color: '#39'#E0E0E3'#39',                    '
    '                    fontSize: '#39'7px'#39
    '                }'
    '            },'
    '            lineColor: '#39'#707073'#39','
    '            minorGridLineColor: '#39'#505053'#39','
    '            tickColor: '#39'#707073'#39','
    '            title: {'
    '                style: {'
    '                    color: '#39'#A0A0A3'#39
    ''
    '                }'
    '            }'
    '        },'
    '        yAxis: {'
    '            gridLineColor: '#39'#707073'#39','
    '            labels: {'
    '                style: {'
    '                    color: '#39'#E0E0E3'#39
    '                }'
    '            },'
    '            lineColor: '#39'#707073'#39','
    '            minorGridLineColor: '#39'#505053'#39','
    '            tickColor: '#39'#707073'#39','
    '            tickWidth: 1,'
    '            title: {'
    '                style: {'
    '                    color: '#39'#A0A0A3'#39
    '                }'
    '            }'
    '        },'
    '        tooltip: {'
    '            backgroundColor: '#39'rgba(0, 0, 0, 0.85)'#39','
    '            style: {'
    '                color: '#39'#F0F0F0'#39
    '            }'
    '        },'
    '        plotOptions: {'
    '            series: {'
    '                dataLabels: {'
    '                    color: '#39'#B0B0B3'#39
    '                },'
    '                marker: {'
    '                    lineColor: '#39'#333'#39
    '                }'
    '            },'
    '            boxplot: {'
    '                fillColor: '#39'#505053'#39
    '            },'
    '            candlestick: {'
    '                lineColor: '#39'white'#39
    '            },'
    '            errorbar: {'
    '                color: '#39'white'#39
    '            }'
    '        },'
    '        legend: {'
    '            itemStyle: {'
    '                color: '#39'#E0E0E3'#39
    '            },'
    '            itemHoverStyle: {'
    '                color: '#39'#FFF'#39
    '            },'
    '            itemHiddenStyle: {'
    '                color: '#39'#606063'#39
    '            }'
    '        },'
    '        credits: {'
    '            style: {'
    '                color: '#39'#666'#39
    '            }'
    '        },'
    '        labels: {'
    '            style: {'
    '                color: '#39'#707073'#39
    '            }'
    '        },'
    ''
    '        drilldown: {'
    '            activeAxisLabelStyle: {'
    '                color: '#39'#F0F0F3'#39
    '            },'
    '            activeDataLabelStyle: {'
    '                color: '#39'#F0F0F3'#39
    '            }'
    '        },'
    ''
    '        navigation: {'
    '            buttonOptions: {'
    '                symbolStroke: '#39'#DDDDDD'#39','
    '                theme: {'
    '                    fill: '#39'#505053'#39
    '                }'
    '            }'
    '        },'
    ''
    '        // scroll charts'
    '        rangeSelector: {'
    '            buttonTheme: {'
    '                fill: '#39'#505053'#39','
    '                stroke: '#39'#000000'#39','
    '                style: {'
    '                    color: '#39'#CCC'#39
    '                },'
    '                states: {'
    '                    hover: {'
    '                        fill: '#39'#707073'#39','
    '                        stroke: '#39'#000000'#39','
    '                        style: {'
    '                            color: '#39'white'#39
    '                        }'
    '                    },'
    '                    select: {'
    '                        fill: '#39'#000003'#39','
    '                        stroke: '#39'#000000'#39','
    '                        style: {'
    '                            color: '#39'white'#39
    '                        }'
    '                    }'
    '                }'
    '            },'
    '            inputBoxBorderColor: '#39'#505053'#39','
    '            inputStyle: {'
    '                backgroundColor: '#39'#333'#39','
    '                color: '#39'silver'#39
    '            },'
    '            labelStyle: {'
    '                color: '#39'silver'#39
    '            }'
    '        },'
    ''
    '        navigator: {'
    '            handles: {'
    '                backgroundColor: '#39'#666'#39','
    '                borderColor: '#39'#AAA'#39
    '            },'
    '            outlineColor: '#39'#CCC'#39','
    '            maskFill: '#39'rgba(255,255,255,0.1)'#39','
    '            series: {'
    '                color: '#39'#7798BF'#39','
    '                lineColor: '#39'#A6C7ED'#39
    '            },'
    '            xAxis: {'
    '                gridLineColor: '#39'#505053'#39
    '            }'
    '        },'
    ''
    '        scrollbar: {'
    '            barBackgroundColor: '#39'#808083'#39','
    '            barBorderColor: '#39'#808083'#39','
    '            buttonArrowColor: '#39'#CCC'#39','
    '            buttonBackgroundColor: '#39'#606063'#39','
    '            buttonBorderColor: '#39'#606063'#39','
    '            rifleColor: '#39'#FFF'#39','
    '            trackBackgroundColor: '#39'#404043'#39','
    '            trackBorderColor: '#39'#404043'#39
    '        },'
    ''
    '        // special colors for some of the'
    '        legendBackgroundColor: '#39'rgba(0, 0, 0, 0.5)'#39','
    '        background2: '#39'#505053'#39','
    '        dataLabelsColor: '#39'#B0B0B3'#39','
    '        textColor: '#39'#C0C0C0'#39','
    '        contrastTextColor: '#39'#F0F0F3'#39','
    '        maskColor: '#39'rgba(255,255,255,0.3)'#39
    '    };'
    ''
    '   // Apply the theme'
    '   Highcharts.setOptions(Highcharts.theme);'
    '    '
    #9'$('#39'#%AUTOMACAO%'#39').highcharts({'
    #9'            '
    #9'    chart: {'
    #9'        polar: true,'
    #9'        type: '#39'area'#39'           '
    #9'    },'
    #9'    '
    #9'    title: {'#9'        '
    '           text: '#39'%TITULOAUTOMACAO%'#39','
    #9'        //x: -50'
    '           x: 0'
    '           '
    #9'    },'
    #9'    '
    #9'    pane: {'#9'    '#9
    '         size: '#39'90%'#39
    #9'    },'
    #9'    '
    #9'    xAxis: {'#9'        '
    '           categories: [%CATEGORIASAUTOMACAO%],'
    #9'        tickmarkPlacement: '#39'on'#39','
    #9'        lineWidth: 0'
    #9'    },'
    #9'        '
    #9'    yAxis: {'
    #9'        gridLineInterpolation: '#39'polygon'#39','
    #9'        lineWidth: 0,'
    #9'        min: 0,'
    '           max: 100,'
    ''
    '              endOnTick: false,'
    '              //showLastLabel: true,'
    '              title: {'
    '                  text: '#39'Conclus'#227'o (%)'#39
    '              },'
    '              labels: {'
    '                  formatter: function () {'
    '                      return this.value + '#39'%'#39';'
    '                  }'
    '              },'
    '              reversedStacks: false           '
    #9'    },'
    #9'    '
    #9'    tooltip: {'
    #9'    '#9'shared: true,'
    
      #9'        pointFormat: '#39'<span style="color:{series.color}">{serie' +
      's.name}: <b>{point.y:,.0f}%</b><br/>'#39
    #9'    },'
    #9'    '
    #9'    legend: {'
    #9'        align: '#39'right'#39','
    #9'        verticalAlign: '#39'top'#39','
    #9'        y: 70,'
    #9'        layout: '#39'vertical'#39','
    #9'        enabled: false'
    #9'    },'
    #9'    '
    #9'    series: [{'
    #9'        name: '#39'Cards'#39','
    #9'        data: [%DATAAUTOMACAO%],'
    #9'        pointPlacement: '#39'on'#39
    #9'    }]'
    #9
    #9'});'
    '});')
  MonitoredKeys.Keys = <>
  OnCreate = UniFormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object UniPageControl1: TUniPageControl
    Left = 0
    Top = 0
    Width = 709
    Height = 640
    Hint = ''
    ActivePage = TSGraficoSPTrelloAutomacao
    Images = UniMainModule.UniImageList
    TabBarVisible = False
    Align = alClient
    Anchors = [akLeft, akTop, akRight, akBottom]
    ClientEvents.ExtEvents.Strings = (
      
        'resize=function resize(sender, width, height, oldWidth, oldHeigh' +
        't, eOpts)'#13#10'{'#13#10'  ajaxRequest(sender, '#39'refreshchart'#39', []);'#13#10'}'
      
        'tabPanel.tabchange=function tabPanel.tabchange(tabPanel, newCard' +
        ', oldCard, eOpts)'#13#10'{'#13#10'  ajaxRequest(tabPanel, '#39'refreshchart'#39', []' +
        ');'#13#10'}')
    TabOrder = 0
    OnAjaxEvent = UniPageControl1AjaxEvent
    object TSGraficoSPTrelloAutomacao: TUniTabSheet
      Hint = ''
      ImageIndex = 0
      Caption = 'Gr'#225'fico SPTrello Automa'#231#227'o'
      DesignSize = (
        701
        612)
      object LbAutomacao: TUniLabel
        Left = 0
        Top = 0
        Width = 701
        Height = 612
        Hint = ''
        TextConversion = txtHTML
        AutoSize = False
        Caption = 'LbAutomacao'
        Align = alClient
        Anchors = [akLeft, akTop, akRight, akBottom]
        ParentColor = False
        Color = clLime
        TabOrder = 0
      end
      object UniPanel3: TUniPanel
        Left = 0
        Top = 105
        Width = 256
        Height = 96
        Hint = ''
        ParentFont = False
        Font.Height = -13
        TabOrder = 1
        BorderStyle = ubsNone
        ShowCaption = False
        Caption = 'UniPanel3'
        Color = clNone
        object LbTotalCards: TUniLabel
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 250
          Height = 48
          Hint = ''
          Alignment = taCenter
          AutoSize = False
          Caption = '00/000'
          Align = alTop
          Anchors = [akLeft, akTop, akRight]
          ParentFont = False
          Font.Color = 9408555
          Font.Height = -40
          TabOrder = 1
        end
        object UniLabel3: TUniLabel
          AlignWithMargins = True
          Left = 3
          Top = 57
          Width = 250
          Height = 23
          Hint = ''
          Alignment = taCenter
          AutoSize = False
          Caption = 'CARDS'
          Align = alTop
          Anchors = [akLeft, akTop, akRight]
          ParentFont = False
          Font.Color = 8555167
          Font.Height = -16
          TabOrder = 2
        end
        object UniPanel5: TUniPanel
          Left = 50
          Top = 67
          Width = 45
          Height = 1
          Hint = ''
          TabOrder = 3
          BorderStyle = ubsNone
          ShowCaption = False
          Caption = ''
          Color = 8555167
        end
        object UniPanel6: TUniPanel
          Left = 160
          Top = 67
          Width = 45
          Height = 1
          Hint = ''
          TabOrder = 4
          BorderStyle = ubsNone
          ShowCaption = False
          Caption = ''
          Color = 8555167
        end
      end
      object UniPanel4: TUniPanel
        Left = 450
        Top = 105
        Width = 256
        Height = 96
        Hint = ''
        Anchors = [akTop, akRight]
        ParentFont = False
        Font.Height = -13
        TabOrder = 2
        BorderStyle = ubsNone
        ShowCaption = False
        Caption = 'UniPanel3'
        Color = clNone
        object LbPercentual: TUniLabel
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 250
          Height = 48
          Hint = ''
          Alignment = taCenter
          AutoSize = False
          Caption = '000%'
          Align = alTop
          Anchors = [akLeft, akTop, akRight]
          ParentFont = False
          Font.Color = 9408555
          Font.Height = -40
          TabOrder = 1
        end
        object UniLabel5: TUniLabel
          AlignWithMargins = True
          Left = 3
          Top = 57
          Width = 250
          Height = 23
          Hint = ''
          Alignment = taCenter
          AutoSize = False
          Caption = 'PROGRESSO'
          Align = alTop
          Anchors = [akLeft, akTop, akRight]
          ParentFont = False
          Font.Color = 8555167
          Font.Height = -16
          TabOrder = 2
        end
        object UniPanel7: TUniPanel
          Left = 30
          Top = 67
          Width = 45
          Height = 1
          Hint = ''
          TabOrder = 3
          BorderStyle = ubsNone
          ShowCaption = False
          Caption = ''
          Color = 8555167
        end
        object UniPanel8: TUniPanel
          Left = 180
          Top = 67
          Width = 45
          Height = 1
          Hint = ''
          TabOrder = 4
          BorderStyle = ubsNone
          ShowCaption = False
          Caption = ''
          Color = 8555167
        end
      end
    end
  end
  object QryQuadros: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 240
    Top = 128
  end
  object QryLista: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 232
    Top = 312
  end
  object QryCards: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 232
    Top = 480
  end
  object UniTimer: TUniTimer
    Interval = 5000
    ChainMode = True
    ClientEvent.Strings = (
      'function(sender)'
      '{'
      ' '
      '}')
    OnTimer = UniTimerTimer
    Left = 500
    Top = 32
  end
  object TblCategorias: TFDMemTable
    FieldDefs = <
      item
        Name = 'id'
        DataType = ftInteger
      end
      item
        Name = 'name'
        DataType = ftString
        Size = 1000
      end
      item
        Name = 'quantidade'
        DataType = ftInteger
      end>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 344
    Top = 145
  end
  object TblSeries: TFDMemTable
    FieldDefs = <
      item
        Name = 'name'
        DataType = ftString
        Size = 1000
      end
      item
        Name = 'lista'
        DataType = ftString
        Size = 1000
      end
      item
        Name = 'quantidade'
        DataType = ftInteger
      end>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 342
    Top = 205
  end
end
