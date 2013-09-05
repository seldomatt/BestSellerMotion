class MySearchBar < UISearchBar

  SCOPES = ["Title", "Author", "Publisher"]

  def initWithFrame(frame)
    super.tap do
      self.showsScopeBar = true
      self.scopeButtonTitles = SCOPES
      self.backgroundImage = "search-bar-bg".uiimage
      self.scopeBarBackgroundImage = "search-bar-bg".uiimage
      format_scope_button_images
      format_scope_button_text
    end
  end

  def format_scope_button_text
    attributes = {
      UITextAttributeTextColor => UIColor.whiteColor,
      UITextAttributeTextShadowOffset => NSValue.valueWithUIOffset(UIOffsetMake(0, 0),
                                                                   UITextAttributeFont => "Helvetica-Neue".uifont(15))
    }
    self.setScopeBarButtonTitleTextAttributes(attributes, forState: UIControlStateNormal)
    self.setScopeBarButtonTitleTextAttributes(attributes, forState: UIControlStateSelected)
  end

  def format_scope_button_images
    self.setScopeBarButtonBackgroundImage("scope-button-bg".uiimage, forState: UIControlStateNormal)
    self.setScopeBarButtonBackgroundImage("scope-button-pressed-bg".uiimage, forState: UIControlStateSelected)
    self.setScopeBarButtonDividerImage("scope-button-divider".uiimage, forLeftSegmentState: UIControlStateNormal, rightSegmentState: UIControlStateNormal)
    self.setScopeBarButtonDividerImage("scope-button-divider".uiimage, forLeftSegmentState: UIControlStateNormal, rightSegmentState: UIControlStateSelected)
    self.setScopeBarButtonDividerImage("scope-button-divider".uiimage, forLeftSegmentState: UIControlStateSelected, rightSegmentState: UIControlStateNormal)
  end
end