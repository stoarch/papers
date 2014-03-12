inherited DocumentEditorForm: TDocumentEditorForm
  Left = 0
  Top = 0
  Caption = #1056#1077#1076#1072#1082#1090#1086#1088' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
  ClientHeight = 572
  ClientWidth = 789
  KeyPreview = True
  OldCreateOrder = True
  Position = poOwnerFormCenter
  OnActivate = FormActivate
  OnCloseQuery = FormCloseQuery
  OnKeyUp = FormKeyUp
  PixelsPerInch = 96
  TextHeight = 13
  inline document_editor_frame: Tdocument_editor_frame [0]
    Left = 0
    Top = 32
    Width = 789
    Height = 521
    Align = alClient
    TabOrder = 0
    inherited document_attachments_editor: Tdocument_attachments_editor
      Top = 399
      Width = 789
      Height = 122
      inherited functions_toolbar: TsToolBar
        Width = 789
      end
      inherited attach_groupBox: TsGroupBox
        Width = 789
        Height = 86
        inherited attachments_list_view: TsListView
          Width = 785
          Height = 43
        end
        inherited urn_label: TsPanel
          Top = 58
          Width = 785
        end
      end
    end
    inherited document_body_editor_frame: Tdocument_body_editor_frame
      Left = 9
      Width = 778
      Height = 318
      inherited sPanel1: TsPanel
        Width = 766
        Height = 306
        inherited doc_kind_combobox: TsComboBox
          Width = 742
        end
        inherited doc_content_group_box: TsGroupBox
          Width = 741
          Height = 239
          inherited content_editorFrame: TRichText_EditorFrame
            Width = 737
            Height = 222
            inherited sPanel1: TsPanel
              Width = 737
            end
            inherited Ruler: TsPanel
              Width = 737
              inherited RulerLine: TsBevel
                Width = 724
              end
              inherited RightInd: TLabel
                Left = 721
              end
            end
            inherited Editor: TsRichEdit
              Width = 737
              Height = 139
            end
            inherited StatusBar: TsStatusBar
              Top = 203
              Width = 737
            end
          end
        end
      end
    end
    inherited document_header_editor_frame: Tdocument_header_editor_frame
      Left = 327
      Width = 455
      inherited src_fio_label: TsLabel
        Width = 443
      end
      inherited src_role_label: TsLabel
        Width = 407
      end
      inherited to_users_comboBox: TsComboBox
        Width = 410
      end
    end
  end
  object sPanel1: TsPanel
    Left = 0
    Top = 0
    Width = 789
    Height = 32
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    SkinData.SkinSection = 'PANEL'
    object button_save: TsButton
      Left = 6
      Top = 3
      Width = 97
      Height = 25
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
      ModalResult = 1
      TabOrder = 0
      OnClick = button_saveClick
      SkinData.SkinSection = 'BUTTON'
    end
    object Cancel_Button: TsButton
      Left = 111
      Top = 3
      Width = 97
      Height = 25
      Caption = #1054#1090#1084#1077#1085#1080#1090#1100
      ModalResult = 2
      TabOrder = 1
      SkinData.SkinSection = 'BUTTON'
    end
  end
  object status_bar: TsStatusBar
    Left = 0
    Top = 553
    Width = 789
    Height = 19
    Panels = <
      item
        Alignment = taCenter
        Text = #1043#1086#1090#1086#1074#1086
        Width = 150
      end
      item
        Width = 50
      end>
    SkinData.SkinSection = 'STATUSBAR'
  end
  object functions_ImageList: TImageList
    Left = 192
    Top = 152
    Bitmap = {
      494C010102000400040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C60000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C6C6C600C6C6C60084000000C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C60084000000840000008400000000000000FFFFFF00C6C6C600C6C6
      C600C6C6C60000000000000000008484000000000000C6C6C600C6C6C600C6C6
      C600C6C6C6000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C6C6C6008400000084000000C6C6
      C6008400000084000000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C6008400000084000000840000000000000084848400C6C6C600C6C6
      C600C6C6C6000000000084840000848400008484000000000000C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C6C6C6008400000084000000C6C6
      C6008400000084000000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C60084000000840000008400000084848400C6C6C600C6C6C600C6C6
      C600C6C6C600000000008484000084840000848400000000000000000000C6C6
      C600C6C6C600C6C6C600C6C6C600000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C6C6C6008400000084000000C6C6
      C6008400000084000000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600840000008400000084000000FFFFFF00C6C6C600C6C6C600FFFF
      FF00FFFFFF000000000000000000848400000000000000000000000000000000
      0000C6C6C600C6C6C600C6C6C600000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C6C6C60084000000840000008400
      0000840000008400000084000000840000008400000084000000840000008400
      000084000000840000008400000084000000FFFFFF00C6C6C600FFFFFF000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C6C6C60084000000840000008400
      0000840000008400000084000000840000008400000084000000840000008400
      000084000000840000008400000084000000FFFFFF00FFFFFF00848400000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000848400008484000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C6C6C6008400000084000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00000000008400000084000000FFFFFF0084840000848400008484
      0000000000000000000000000000000000000000000000000000000000008484
      0000848400008484000084840000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C6C6C6008400000084000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000084000000840000008484000084840000848400008484
      0000848400000000000000000000000000000000000000000000000000008484
      0000848400008484000084840000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C6C6C6008400000084000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000084000000840000000000000084840000848400008484
      0000000000000000000000000000000000000000000000000000000000000000
      0000848400008484000084848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C6C6C6008400000084000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000084000000840000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000084848400C6C6C600000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C6C6C6008400000084000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00000000008400000084000000FFFFFF00C6C6C600C6C6C600C6C6
      C600000000000000000000000000000000000000000000000000C6C6C6000000
      000084848400C6C6C600C6C6C600000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C6C6C6008400000084000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00000000008400000084000000FFFFFF00C6C6C600C6C6C600C6C6
      C600000000000000000000000000848400008484000000000000C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C6C6C6000000000084000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00000000008400000084000000FFFFFF00C6C6C600C6C6C600C6C6
      C600C6C6C6000000000084840000848400008484000084840000C6C6C600C6C6
      C600C6C6C600C6C6C600FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000840000008400000000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF00000000008400000084000000FFFFFF0000000000C6C6C600C6C6
      C600C6C6C600C6C6C60000000000848400008484000000000000C6C6C600C6C6
      C600C6C6C600C6C6C60000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084000000840000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000008400000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00C0030206000000000000800000000000
      00008000000000000000000000000000000000600000000000001AC000000000
      00001FF30000000000000FE100000000000007E00000000000008FF000000000
      000003F800000000000006500000000000000400000000000000000100000000
      8000000300000000800140410000000000000000000000000000000000000000
      000000000000}
  end
end