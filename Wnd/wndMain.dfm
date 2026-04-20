object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'QuickLauncher'
  ClientHeight = 441
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  TextHeight = 15
  object tray: TTrayIcon
    Left = 120
    Top = 344
  end
  object mnuLeft: TPopupMenu
    Left = 256
    Top = 320
  end
  object mnuRight: TPopupMenu
    Left = 352
    Top = 320
  end
end
