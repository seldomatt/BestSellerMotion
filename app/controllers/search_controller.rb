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

  #delegate method
  def searchBarSearchButtonClicked(searchBar)
    search_best_sellers(searchBar)
    searchBar.resignFirstResponder
  end

  def search_best_sellers(searchBar)
    hud = MBProgressHUD.showHUDAddedTo(view, animated: true)
    hud.labelText = "Searching..."
    search_scope = MySearchBar::SCOPES[searchBar.selectedScopeButtonIndex]
    search_text = searchBar.text
    5.seconds.later do
      BestSellerApi.search(search_text, search_scope) do |data, error|
        if error
          App.alert("Server Error")
        else
          results_controller = SearchResultsController.alloc.initWithResults(data["results"], query:search_text, andScope:search_scope)
          navigationController.pushViewController(results_controller, animated: true)
        end
        MBProgressHUD.hideHUDForView(view, animated: true)
      end
    end
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
          constrain_below(:search, 0),
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
