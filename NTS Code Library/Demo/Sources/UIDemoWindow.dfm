object DemoWindow: TDemoWindow
  Left = 0
  Top = 0
  Caption = 'DemoWindow'
  ClientHeight = 356
  ClientWidth = 431
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 265
    Height = 105
    Caption = 'Window Config'
    TabOrder = 0
    object CheckBox1: TCheckBox
      Left = 24
      Top = 24
      Width = 225
      Height = 17
      Caption = 'Show caption bar'
      Checked = True
      State = cbChecked
      TabOrder = 0
      OnClick = CheckBox1Click
    end
    object Button1: TButton
      Left = 24
      Top = 47
      Width = 225
      Height = 41
      Caption = 'Browse for icon'
      TabOrder = 1
      OnClick = Button1Click
    end
  end
  object WindowConfig: TWindowConfig
    ShowInTaskBar = False
    Left = 232
    Top = 24
  end
end
