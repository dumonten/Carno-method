object Form1: TForm1
  Left = -107
  Top = 149
  Width = 1328
  Height = 839
  Caption = 'Form'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object MapTable: TStringGrid
    Left = 576
    Top = 64
    Width = 577
    Height = 481
    ColCount = 3
    DefaultColWidth = 30
    RowCount = 3
    ScrollBars = ssNone
    TabOrder = 3
    RowHeights = (
      24
      24
      24)
  end
  object TTable: TStringGrid
    Left = 216
    Top = 64
    Width = 305
    Height = 513
    ColCount = 3
    DefaultColWidth = 100
    FixedCols = 2
    ScrollBars = ssVertical
    TabOrder = 0
    OnSelectCell = TTableSelectCell
  end
  object Start: TButton
    Left = 80
    Top = 96
    Width = 89
    Height = 49
    Caption = #1057#1090#1072#1088#1090
    TabOrder = 1
    OnClick = StartClick
  end
  object VarCount: TRadioGroup
    Left = 64
    Top = 248
    Width = 129
    Height = 161
    Caption = #1063#1080#1089#1083#1086' '#1055#1077#1088#1077#1084#1077#1085#1085#1099#1093
    Items.Strings = (
      'n = Random'
      'n = 2'
      'n = 3'
      'n = 4'
      'n = 5'
      'n = 6'
      'n = 7'
      'n = 8')
    TabOrder = 2
    OnClick = VarCountClick
  end
  object FuncValue: TComboBox
    Left = 40
    Top = 744
    Width = 65
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 4
    OnExit = FuncValueExit
    Items.Strings = (
      '0'
      '1'
      'x')
  end
  object Col_Name: TStaticText
    Left = 464
    Top = 592
    Width = 53
    Height = 17
    Caption = 'Col_Name'
    TabOrder = 5
  end
  object Row_Name: TStaticText
    Left = 464
    Top = 624
    Width = 60
    Height = 17
    Caption = 'Row_Name'
    TabOrder = 6
  end
end