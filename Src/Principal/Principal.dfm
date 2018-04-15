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
    #9'$('#39'#%AUTOMACAO%'#39').highcharts({'
    #9'            '
    #9'    chart: {'
    #9'        polar: true,'
    #9'        type: '#39'area'#39', '
    '           downloadCSV: "Download CSV teste"            '
    #9'    },'
    #9'    '
    #9'    title: {'
    #9'        //text: '#39'Budget vs spending'#39','
    '           text: '#39'%TITULOAUTOMACAO%'#39','
    #9'        x: -50'
    #9'    },'
    #9'    '
    #9'    pane: {'
    #9'    '#9'size: '#39'80%'#39
    #9'    },'
    #9'    '
    #9'    xAxis: {'
    
      #9'        //categories: ['#39'Sales'#39', '#39'Marketing'#39', '#39'Development'#39', '#39'Cu' +
      'stomer Support'#39', '#39'Information Technology'#39', '#39'Administration'#39'],'
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
    #9'        layout: '#39'vertical'#39
    #9'    },'
    #9'    '
    #9'    series: [{'
    #9'        name: '#39'Cards'#39','
    
      #9'        //data: [43000, 19000, 60000, 35000, 17000, 10000, 5000' +
      ', 3000, 0, 0],'
    #9#9#9'  data: [%DATAAUTOMACAO%],'
    #9'        pointPlacement: '#39'on'#39
    #9'    }/*, {'
    #9'        name: '#39'Actual Spending'#39','
    #9'        data: [50000, 39000, 42000, 31000, 26000, 14000],'
    #9'        pointPlacement: '#39'on'#39
    #9'    }*/]'
    #9
    #9'});'
    '});'
    ''
    '$(function() {'
    '    Highcharts.setOptions({'
    '        chart: {'
    '            backgroundColor: {'
    '                linearGradient: [0, 0, 500, 500],'
    '                stops: ['
    '                    [0, '#39'rgb(255, 255, 255)'#39'],'
    '                    [1, '#39'rgb(240, 240, 255)'#39']'
    '                    ]'
    '            },'
    '            borderWidth: 2,'
    '            plotBackgroundColor: '#39'rgba(255, 255, 255, .9)'#39','
    '            plotShadow: true,'
    '            plotBorderWidth: 1'
    '        }'
    '    });'
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
    ActivePage = TSGraficoSonarAutomacao
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
    object TSGraficoSonarAutomacao: TUniTabSheet
      Hint = ''
      Caption = 'Gr'#225'fico Sonar Automa'#231#227'o'
      object LbAutomacao: TUniLabel
        Left = 0
        Top = 35
        Width = 701
        Height = 577
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
      object UniPanel1: TUniPanel
        Left = 0
        Top = 0
        Width = 701
        Height = 35
        Hint = ''
        Align = alTop
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 1
        BorderStyle = ubsNone
        ShowCaption = False
        Caption = 'UniPanel1'
        DesignSize = (
          701
          35)
        object BtnAtualizarSonarAutomacao: TUniSpeedButton
          Left = 590
          Top = 5
          Width = 100
          Height = 25
          Hint = ''
          Caption = 'Atualizar'
          Anchors = [akTop, akRight]
          ParentColor = False
          Color = clWindow
          ScreenMask.Enabled = True
          ScreenMask.WaitData = True
          TabOrder = 1
          OnClick = BtnAtualizarSonarAutomacaoClick
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
  object cdsCategorias: TClientDataSet
    Aggregates = <>
    FieldDefs = <
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
    Params = <>
    StoreDefs = True
    Left = 524
    Top = 176
  end
  object cdsSeries: TClientDataSet
    Aggregates = <>
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
    IndexFieldNames = 'name;lista'
    Params = <>
    StoreDefs = True
    Left = 516
    Top = 248
  end
end
