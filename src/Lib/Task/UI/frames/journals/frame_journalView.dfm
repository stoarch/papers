inherited JournalViewFrame: TJournalViewFrame
  Width = 605
  Height = 424
  inherited content_panel: TbsSkinPanel
    Width = 605
    Height = 424
    object journal_group_box: TbsSkinGroupBox
      Left = 1
      Top = 1
      Width = 603
      Height = 422
      TabOrder = 0
      SkinDataName = 'groupbox'
      DefaultFont.Charset = DEFAULT_CHARSET
      DefaultFont.Color = clWindowText
      DefaultFont.Height = 14
      DefaultFont.Name = 'Arial'
      DefaultFont.Style = []
      DefaultWidth = 0
      DefaultHeight = 0
      UseSkinFont = True
      RealHeight = -1
      AutoEnabledControls = True
      CheckedMode = False
      Checked = False
      DefaultAlignment = taLeftJustify
      DefaultCaptionHeight = 22
      BorderStyle = bvFrame
      CaptionMode = True
      RollUpMode = False
      RollUpState = False
      NumGlyphs = 1
      Spacing = 2
      Caption = #1046#1091#1088#1085#1072#1083
      Align = alClient
      object journal_grid: TbsSkinStringGrid
        Left = 1
        Top = 23
        Width = 582
        Height = 379
        TabOrder = 0
        SkinDataName = 'grid'
        UseSkinFont = True
        UseSkinCellHeight = True
        HScrollBar = journal_hscroll
        VScrollBar = journal_vscroll
        GridLineColor = clWindowText
        DefaultCellHeight = 20
        Align = alClient
        ColCount = 2
        DefaultRowHeight = 20
        RowCount = 3
        FixedRows = 2
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRowSelect]
      end
      object journal_vscroll: TbsSkinScrollBar
        Left = 583
        Top = 23
        Width = 19
        Height = 379
        TabOrder = 1
        Visible = False
        SkinDataName = 'vscrollbar'
        DefaultFont.Charset = DEFAULT_CHARSET
        DefaultFont.Color = clWindowText
        DefaultFont.Height = 14
        DefaultFont.Name = 'Arial'
        DefaultFont.Style = []
        DefaultWidth = 19
        DefaultHeight = 0
        UseSkinFont = True
        Both = False
        BothMarkerWidth = 19
        BothSkinDataName = 'bothhscrollbar'
        CanFocused = False
        Align = alRight
        Kind = sbVertical
        PageSize = 0
        Min = 0
        Max = 0
        Position = 0
        SmallChange = 1
        LargeChange = 1
      end
      object journal_hscroll: TbsSkinScrollBar
        Left = 1
        Top = 402
        Width = 601
        Height = 19
        TabOrder = 2
        Visible = False
        SkinDataName = 'hscrollbar'
        DefaultFont.Charset = DEFAULT_CHARSET
        DefaultFont.Color = clWindowText
        DefaultFont.Height = 14
        DefaultFont.Name = 'Arial'
        DefaultFont.Style = []
        DefaultWidth = 0
        DefaultHeight = 19
        UseSkinFont = True
        Both = False
        BothMarkerWidth = 19
        BothSkinDataName = 'bothhscrollbar'
        CanFocused = False
        Align = alBottom
        Kind = sbHorizontal
        PageSize = 0
        Min = 0
        Max = 0
        Position = 0
        SmallChange = 1
        LargeChange = 1
      end
    end
  end
end
