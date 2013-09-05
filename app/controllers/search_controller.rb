class SearchController < UIViewController

  stylesheet :search_controller

  layout do
    subview("search-bg".uiimageview, :background)
    subview(MySearchBar.alloc.initWithFrame([[0, 0], [320, 88]]), :search, delegate: self)
    subview(UIView, :label_container) do
      subview("Search the NYTimes Best Seller's List!".uilabel, :text)
    end
  end

  def viewWillAppear(animated)
    navigationController.navigationBarHidden = true
  end

end

Teacup::Stylesheet.new(:search_controller) do

  style :background,
        top: 0,
        left: 0,
        userInteractionEnabled: true

  style :label_container,
        constraints: [
          constrain_left(0),
          constrain_below(:search,0),
          constrain_height(100),
          constrain_width(150)
        ],
        backgroundColor: "#CF755C".uicolor

  style :text,
        constraints: [
          constrain_left(10),
          constrain_top(10)
        ],
        numberOfLines: 0,
        lineBreakMode: NSLineBreakByWordWrapping,
        preferredMaxLayoutWidth: 130,
        backgroundColor: "#CF755C".uicolor,
        color: :white.uicolor,
        font: "Helvetica".uifont(20)

end
