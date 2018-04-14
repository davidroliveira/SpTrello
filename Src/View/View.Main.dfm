object Main: TMain
  Left = 0
  Top = 0
  ClientHeight = 640
  ClientWidth = 709
  Caption = 'Main'
  OldCreateOrder = False
  Script.Strings = (
    '$(function () {'
    ''
    #9'$('#39'#container'#39').highcharts({'
    #9'            '
    #9'    chart: {'
    #9'        polar: true,'
    #9'        type: '#39'line'#39
    #9'    },'
    #9'    '
    #9'    title: {'
    #9'        text: '#39'Budget vs spending'#39','
    #9'        x: -80'
    #9'    },'
    #9'    '
    #9'    pane: {'
    #9'    '#9'size: '#39'100%'#39
    #9'    },'
    #9'    '
    #9'    xAxis: {'
    
      #9'        categories: ['#39'Sales'#39', '#39'Marketing'#39', '#39'Development'#39', '#39'Cust' +
      'omer Support'#39', '#39'Information Technology'#39', '#39'Administration'#39'],'
    #9'        tickmarkPlacement: '#39'on'#39','
    #9'        lineWidth: 0'
    #9'    },'
    #9'        '
    #9'    yAxis: {'
    #9'        gridLineInterpolation: '#39'polygon'#39','
    #9'        lineWidth: 0,'
    #9'        min: 0'
    #9'    },'
    #9'    '
    #9'    tooltip: {'
    #9'    '#9'shared: true,'
    
      #9'        pointFormat: '#39'<span style="color:{series.color}">{serie' +
      's.name}: <b>${point.y:,.0f}</b><br/>'#39
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
    #9'        name: '#39'Allocated Budget'#39','
    #9'        data: [43000, 19000, 60000, 35000, 17000, 10000],'
    #9'        pointPlacement: '#39'on'#39
    #9'    }, {'
    #9'        name: '#39'Actual Spending'#39','
    #9'        data: [50000, 39000, 42000, 31000, 26000, 14000],'
    #9'        pointPlacement: '#39'on'#39
    #9'    }]'
    #9
    #9'});'
    '});'
    ''
    ''
    'function _resizeTablet() {'
    '    document.getElementById("viewport").style.width = "1200px";'
    '    Highcharts.charts.forEach(function(chart) {'
    '        chart.reflow();'
    '    });'
    '}'
    ''
    'function _resizeDesktop() {'
    '    document.getElementById("viewport").style.width = "1700px";'
    '    Highcharts.charts.forEach(function(chart) {'
    '        chart.reflow();'
    '    });'
    ''
    '}')
  MonitoredKeys.Keys = <>
  OnCreate = UniFormCreate
  OnDestroy = UniFormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object UniPageControl1: TUniPageControl
    Left = 0
    Top = 0
    Width = 709
    Height = 640
    Hint = ''
    ActivePage = UniTabSheet2
    Align = alClient
    Anchors = [akLeft, akTop, akRight, akBottom]
    ClientEvents.ExtEvents.Strings = (
      
        'resize=function resize(sender, width, height, oldWidth, oldHeigh' +
        't, eOpts)'#13#10'{'#13#10'  //alert("Hello! I am an alert box!!");'#13#10'  //$('#39'#' +
        'container'#39').highcharts().reflow();'#13#10'  ajaxRequest(sender, '#39'resiz' +
        'e'#39', []);'#13#10'}')
    TabOrder = 0
    OnAjaxEvent = UniPageControl1AjaxEvent
    object UniTabSheet1: TUniTabSheet
      Hint = ''
      Caption = 'UniTabSheet1'
      DesignSize = (
        701
        612)
      object GridCards: TUniDBGrid
        Left = 3
        Top = 418
        Width = 666
        Height = 160
        Hint = ''
        DataSource = DSCards
        LoadMask.Message = 'Loading data...'
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 0
      end
      object GridLista: TUniDBGrid
        Left = 0
        Top = 242
        Width = 666
        Height = 160
        Hint = ''
        DataSource = DSLista
        LoadMask.Message = 'Loading data...'
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 1
      end
      object GridQuadros: TUniDBGrid
        Left = 0
        Top = 55
        Width = 666
        Height = 160
        Hint = ''
        DataSource = DSQuadros
        LoadMask.Message = 'Loading data...'
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 2
      end
      object UniButton2: TUniButton
        Left = 8
        Top = 24
        Width = 75
        Height = 25
        Hint = ''
        Caption = 'Abrir'
        TabOrder = 3
        ScreenMask.Enabled = True
        ScreenMask.WaitData = True
        OnClick = UniButton2Click
      end
    end
    object UniTabSheet2: TUniTabSheet
      Hint = ''
      Caption = 'UniTabSheet2'
      object UniLabel1: TUniLabel
        Left = 0
        Top = 0
        Width = 701
        Height = 612
        Hint = ''
        TextConversion = txtHTML
        AutoSize = False
        Caption = 
          '<div id="container" style="width: 100%; height: 100%; margin: 0 ' +
          'auto"></div>'
        Align = alClient
        Anchors = [akLeft, akTop, akRight, akBottom]
        ParentColor = False
        Color = clLime
        TabOrder = 0
      end
    end
  end
  object QryQuadros: TFDMemTable
    AfterScroll = QryQuadrosAfterScroll
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
  object DSQuadros: TDataSource
    DataSet = QryQuadros
    Left = 296
    Top = 128
  end
  object QryLista: TFDMemTable
    AfterScroll = QryListaAfterScroll
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
  object DSLista: TDataSource
    DataSet = QryLista
    Left = 288
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
  object DSCards: TDataSource
    DataSet = QryCards
    Left = 288
    Top = 480
  end
end
