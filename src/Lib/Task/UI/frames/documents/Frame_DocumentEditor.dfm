inherited document_editor_frame: Tdocument_editor_frame
  Width = 443
  Height = 277
  Align = alClient
  DesignSize = (
    443
    277)
  inline document_attachments_editor: Tdocument_attachments_editor [0]
    Left = 0
    Top = 141
    Width = 443
    Height = 136
    Align = alBottom
    TabOrder = 0
    inherited functions_toolbar: TsToolBar
      Width = 443
    end
    inherited attach_groupBox: TsGroupBox
      Width = 443
      Height = 100
      inherited attachments_list_view: TsListView
        Width = 439
        Height = 57
      end
      inherited urn_label: TsPanel
        Top = 72
        Width = 439
      end
    end
  end
  inline document_body_editor_frame: Tdocument_body_editor_frame
    Left = 3
    Top = 78
    Width = 621
    Height = 364
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 1
    DesignSize = (
      621
      364)
    inherited sPanel1: TsPanel
      Left = 6
      Top = 6
      Height = 352
      DesignSize = (
        609
        352)
      inherited doc_content_group_box: TsGroupBox
        Left = 12
        Top = 54
        Height = 285
        inherited content_editorFrame: TRichText_EditorFrame
          Height = 268
          inherited Ruler: TsPanel
            TabOrder = 3
            inherited FirstInd: TLabel
              OnMouseDown = nil
              OnMouseMove = nil
              OnMouseUp = nil
            end
            inherited LeftInd: TLabel
              OnMouseDown = nil
              OnMouseMove = nil
              OnMouseUp = nil
            end
            inherited RightInd: TLabel
              OnMouseDown = nil
              OnMouseMove = nil
              OnMouseUp = nil
            end
          end
          inherited Editor: TsRichEdit
            Height = 185
            TabOrder = 1
          end
          inherited StatusBar: TsStatusBar
            Top = 249
          end
        end
      end
    end
  end
  inline document_header_editor_frame: Tdocument_header_editor_frame
    Left = 342
    Top = 6
    Width = 280
    Height = 64
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 2
    inherited sLabel1: TsLabel
      Top = 6
    end
    inherited sLabel2: TsLabel
      Top = 30
    end
    inherited src_fio_label: TsLabel
      Top = 48
      Width = 268
    end
    inherited src_role_label: TsLabel
      Left = 39
      Top = 30
      Width = 232
    end
    inherited to_users_comboBox: TsComboBox
      Top = 3
      Width = 235
    end
  end
  inherited Frame_Adapter: TsFrameAdapter
    Left = 123
    Top = 90
  end
end
