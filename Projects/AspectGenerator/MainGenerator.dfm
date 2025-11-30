object frmMainGenerator: TfrmMainGenerator
  Left = 0
  Top = 0
  Caption = 'frmMainGenerator'
  ClientHeight = 514
  ClientWidth = 1143
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 1143
    Height = 81
    Align = alTop
    Caption = 'pnlTop'
    ShowCaption = False
    TabOrder = 0
    object lblNameTable: TLabel
      Left = 16
      Top = 12
      Width = 91
      Height = 13
      Caption = #1048#1084#1077' '#1085#1072' '#1090#1072#1073#1083#1080#1094#1072#1090#1072
    end
    object edtNameTable: TEdit
      Left = 16
      Top = 31
      Width = 290
      Height = 21
      TabOrder = 0
      Text = 'PregledNew'
    end
    object btnGenCode: TButton
      Left = 327
      Top = 29
      Width = 154
      Height = 25
      Caption = #1043#1077#1085#1077#1088#1080#1088#1072#1081' '#1082#1086#1076#1072
      TabOrder = 1
      OnClick = btnGenCodeClick
    end
    object btnProcInsert: TButton
      Left = 816
      Top = 13
      Width = 75
      Height = 25
      Caption = 'btnProcInsert'
      TabOrder = 2
      OnClick = btnProcInsertClick
    end
  end
  object vlsProp: TValueListEditor
    Left = 0
    Top = 81
    Width = 306
    Height = 433
    Align = alLeft
    Color = clBtnFace
    DrawingStyle = gdsClassic
    KeyOptions = [keyEdit, keyAdd, keyDelete, keyUnique]
    Strings.Strings = (
      'ADDRESS_ACT=AnsiString'
      'ADDRESS_DOGNZOK=AnsiString'
      'ADRES=AnsiString'
      'BANKA=AnsiString'
      'BANKOW_KOD=AnsiString'
      'BULSTAT=AnsiString'
      'COMPANYNAME=AnsiString'
      'CONTRACT_DATE=TDate'
      'CONTRACT_RZOK=AnsiString'
      'CONTRACT_TYPE=word'
      'DAN_NOMER=AnsiString'
      'EGN=AnsiString'
      'FNAME=AnsiString'
      'FULLNAME=AnsiString'
      'INVOICECOMPANY=boolean'
      'ISSUER_TYPE=boolean'
      'IS_SAMOOSIG=boolean'
      'KOD_RAJON=AnsiString'
      'KOD_RZOK=AnsiString'
      'LNAME=AnsiString'
      'LNCH=AnsiString'
      'NAME=AnsiString'
      'NAS_MQSTO=AnsiString'
      'NEBL_USL=double'
      'NOMER_LZ=AnsiString'
      'NOM_NAP=AnsiString'
      'NZOK_NOMER=AnsiString'
      'OBLAST=AnsiString'
      'OBSHTINA=AnsiString'
      'SELF_INSURED_DECLARATION=boolean'
      'SMETKA=AnsiString'
      'SNAME=AnsiString'
      'UPRAVITEL=AnsiString'
      'VIDFIRMA=AnsiString'
      'VID_IDENT=AnsiString'
      'VID_PRAKTIKA=AnsiString')
    TabOrder = 1
    TitleCaptions.Strings = (
      'property'
      'type')
    ColWidths = (
      150
      133)
    RowHeights = (
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18)
  end
  object pnlWork: TPanel
    Left = 306
    Top = 81
    Width = 837
    Height = 433
    Align = alClient
    Caption = 'pnlWork'
    TabOrder = 2
    object pgcWork: TPageControl
      Left = 1
      Top = 1
      Width = 835
      Height = 431
      ActivePage = tsDDL
      Align = alClient
      TabOrder = 0
      object tsTable: TTabSheet
        Caption = 'tsTable'
        object SynMemo1: TSynMemo
          Left = 0
          Top = 0
          Width = 827
          Height = 403
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          TabOrder = 0
          CodeFolding.GutterShapeSize = 11
          CodeFolding.CollapsedLineColor = clGrayText
          CodeFolding.FolderBarLinesColor = clGrayText
          CodeFolding.IndentGuidesColor = clGray
          CodeFolding.IndentGuides = True
          CodeFolding.ShowCollapsedLine = False
          CodeFolding.ShowHintMark = True
          UseCodeFolding = False
          Gutter.Font.Charset = DEFAULT_CHARSET
          Gutter.Font.Color = clWindowText
          Gutter.Font.Height = -11
          Gutter.Font.Name = 'Courier New'
          Gutter.Font.Style = []
          Highlighter = SynPasSyn1
          Lines.Strings = (
            'SynMemo1')
          Options = [eoAutoIndent, eoDisableScrollArrows, eoDragDropEditing, eoEnhanceEndKey, eoGroupUndo, eoScrollPastEol, eoShowScrollHint, eoSmartTabDelete, eoTabsToSpaces]
          SearchEngine = SynEditSearch1
          FontSmoothing = fsmNone
        end
      end
      object tsAddTable: TTabSheet
        Caption = 'tsAddTable'
        ImageIndex = 1
        object pnlAddTable: TPanel
          Left = 0
          Top = 0
          Width = 827
          Height = 41
          Align = alTop
          Caption = 'pnlAddTable'
          ParentBackground = False
          ShowCaption = False
          TabOrder = 0
          object btnAddTable: TButton
            Left = 16
            Top = 10
            Width = 75
            Height = 25
            Caption = 'btnAddTable'
            TabOrder = 0
            OnClick = btnAddTableClick
          end
          object btnDBHelperUpdate: TButton
            Left = 97
            Top = 10
            Width = 120
            Height = 25
            Caption = 'DbHelperUpdate'
            TabOrder = 1
            OnClick = btnDBHelperUpdateClick
          end
          object btnDbHelperInsert: TButton
            Left = 223
            Top = 10
            Width = 120
            Height = 25
            Caption = 'DbHelperIndert'
            TabOrder = 2
            OnClick = btnDbHelperInsertClick
          end
          object btnCMDFillProp: TButton
            Left = 360
            Top = 8
            Width = 169
            Height = 25
            Caption = 'btnCMDFillProp'
            TabOrder = 3
            OnClick = btnCMDFillPropClick
          end
        end
        object synmaddTable: TSynMemo
          Left = 0
          Top = 41
          Width = 827
          Height = 362
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          TabOrder = 1
          CodeFolding.GutterShapeSize = 11
          CodeFolding.CollapsedLineColor = clGrayText
          CodeFolding.FolderBarLinesColor = clGrayText
          CodeFolding.IndentGuidesColor = clGray
          CodeFolding.IndentGuides = True
          CodeFolding.ShowCollapsedLine = False
          CodeFolding.ShowHintMark = True
          UseCodeFolding = False
          Gutter.Font.Charset = DEFAULT_CHARSET
          Gutter.Font.Color = clWindowText
          Gutter.Font.Height = -11
          Gutter.Font.Name = 'Courier New'
          Gutter.Font.Style = []
          Highlighter = SynPasSyn1
          Lines.Strings = (
            'SynMemo1')
          Options = [eoAutoIndent, eoDisableScrollArrows, eoDragDropEditing, eoEnhanceEndKey, eoGroupUndo, eoScrollPastEol, eoShowScrollHint, eoSmartTabDelete, eoTabsToSpaces]
          SearchEngine = SynEditSearch1
          FontSmoothing = fsmNone
        end
      end
      object tsDDL: TTabSheet
        Caption = 'tsDDL'
        ImageIndex = 2
        object mmoDDL: TMemo
          Left = 0
          Top = 41
          Width = 827
          Height = 362
          Align = alClient
          Color = clInactiveCaption
          Lines.Strings = (
            'ADDRESS_ACT=AnsiString'
            'ADDRESS_DOGNZOK=AnsiString'
            'ADRES=AnsiString'
            'BANKA=AnsiString'
            'BANKOW_KOD=AnsiString'
            'BULSTAT=AnsiString'
            'COMPANYNAME=AnsiString'
            'CONTRACT_DATE=TDate'
            'CONTRACT_RZOK=AnsiString'
            'CONTRACT_TYPE=word'
            'DAN_NOMER=AnsiString'
            'EGN=AnsiString'
            'FNAME=AnsiString'
            'FULLNAME=AnsiString'
            'INVOICECOMPANY=boolean'
            'ISSUER_TYPE=boolean'
            'IS_SAMOOSIG=boolean'
            'KOD_RAJON=AnsiString'
            'KOD_RZOK=AnsiString'
            'LNAME=AnsiString'
            'LNCH=AnsiString'
            'NAME=AnsiString'
            'NAS_MQSTO=AnsiString'
            'NEBL_USL=double'
            'NOMER_LZ=AnsiString'
            'NOM_NAP=AnsiString'
            'NZOK_NOMER=AnsiString'
            'OBLAST=AnsiString'
            'OBSHTINA=AnsiString'
            'SELF_INSURED_DECLARATION=boolean'
            'SMETKA=AnsiString'
            'SNAME=AnsiString'
            'UPRAVITEL=AnsiString'
            'VIDFIRMA=AnsiString'
            'VID_IDENT=AnsiString'
            'VID_PRAKTIKA=AnsiString')
          ScrollBars = ssBoth
          TabOrder = 0
        end
        object pnlTopDDL: TPanel
          Left = 0
          Top = 0
          Width = 827
          Height = 41
          Align = alTop
          Caption = 'pnlTopDDL'
          ParentBackground = False
          ShowCaption = False
          TabOrder = 1
          DesignSize = (
            827
            41)
          object btnGenDDL: TButton
            Left = 375
            Top = 8
            Width = 143
            Height = 25
            Anchors = [akTop, akRight]
            Caption = 'DDL '#1085#1072' '#1090#1072#1073#1083#1080#1094#1072#1090#1072
            TabOrder = 1
            OnClick = btnGenDDLClick
          end
          object cbbTableName: TComboBox
            Left = 16
            Top = 8
            Width = 353
            Height = 24
            Style = csDropDownList
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            OnDblClick = cbbTableNameDblClick
          end
          object btnLoadProp: TButton
            Left = 667
            Top = 10
            Width = 147
            Height = 25
            Anchors = [akTop, akRight]
            Caption = #1079#1072#1088#1077#1078#1076#1072#1085#1077' '#1085#1072' '#1087#1086#1083#1077#1090#1072#1090#1072
            TabOrder = 2
            OnClick = btnLoadPropClick
          end
          object btnDDlFromFile: TButton
            Left = 528
            Top = 8
            Width = 113
            Height = 25
            Caption = 'btnDDlFromFile'
            TabOrder = 3
            OnClick = btnDDlFromFileClick
          end
        end
      end
      object tsInsertField: TTabSheet
        Caption = 'tsInsertField'
        ImageIndex = 3
      end
    end
  end
  object SynPasSyn1: TSynPasSyn
    Options.AutoDetectEnabled = False
    Options.AutoDetectLineLimit = 0
    Options.Visible = True
    Left = 704
    Top = 200
  end
  object SynEditSearch1: TSynEditSearch
    Left = 712
    Top = 144
  end
  object DBMain: TIBDatabase
    Connected = True
    DatabaseName = 'D:\Biser\bazaDanni\HIPPOCRATES_Prolab\HIPPOCRATES.GDB'
    Params.Strings = (
      'user_name=sysdba'
      'password=masterkey')
    LoginPrompt = False
    DefaultTransaction = traMain
    ServerType = 'IBServer'
    Left = 808
    Top = 208
  end
  object traMain: TIBTransaction
    Active = True
    Left = 871
    Top = 208
  end
  object ibsqlCMD: TIBSQL
    Database = DBMain
    SQL.Strings = (
      
        'select pr.amb_listn, pr.anamn, pr.start_date, pr.is_medbelejka f' +
        'rom pregled pr')
    Transaction = traMain
    Left = 928
    Top = 208
  end
  object dlgOpenDDL: TOpenDialog
    Filter = 'DDL|*.ddl'
    InitialDir = 'D:\VSS\Delphi10Seattle\Projects\AspectGenerator\Win32'
    Left = 896
    Top = 296
  end
  object dlgOpenPas: TOpenDialog
    Filter = 'Pas|*.pas'
    InitialDir = 'D:\VSS\Delphi10Seattle\Projects\TestSuperHip\Aspects\Tables'
    Left = 992
    Top = 336
  end
end
