class SearchResultsController < UIViewController

  stylesheet :search_results

  def initWithResults(results)
    init.tap do
      @results = results
      self.title = "Results"
    end
  end

  layout :root do
    @table = subview(UITableView, :results_table, delegate:self, dataSource: self)
  end

  def layoutDidLoad
    setup_navbar
    App.alert("No search results") if @results.empty?
    @table.registerClass(SearchResultsTableViewCell, forCellReuseIdentifier:"cell_identifier")
  end

  #tableView dataSource protocols
  def tableView(tableView, numberOfRowsInSection:section)
    @results.length
  end

  def tableView(tableView, heightForRowAtIndexPath:indexPath)
    105
  end

  def tableView(tableView, cellForRowAtIndexPath:indexPath)
    tableView.dequeueReusableCellWithIdentifier("cell_identifier", forIndexPath:indexPath).tap do |cel|
      cel.title.text = normalize(@results[indexPath.row]["title"])
      cel.author.text = @results[indexPath.row]["author"]
      cel.publisher.text = @results[indexPath.row]["publisher"]
    end
  end

  private

  def setup_navbar
    App.shared.statusBarStyle = UIStatusBarStyleBlackOpaque
    navigationController.navigationBar.setBackgroundImage("results-nav-bg".uiimage, forBarMetrics: UIBarMetricsDefault)
    navigationController.navigationBarHidden = false
    set_up_back_button
  end

  def set_up_back_button
    btn = layout(UIButton, :back_button).on(:touch) do
      navigationController.popViewControllerAnimated(true)
    end
    bar_btn = UIBarButtonItem.alloc.initWithCustomView(btn)
    navigationItem.setLeftBarButtonItem(bar_btn, animated: false)
  end

  def normalize(text)
    split = text.split(" ")
    normalized = split.map{|word| word.capitalize}
    normalized.join(" ")
  end

end


Teacup::Stylesheet.new(:search_results) do

  style :back_button,
        bg_image: 'back-button'.uiimage,
        highlighted: {
          bg_image: 'back-button-pressed'.uiimage
        }

  style :results_table,
        constraints: [
          :full
        ],
        separatorStyle: UITableViewCellSeparatorStyleNone,
        backgroundColor: UIColor.colorWithPatternImage("table-bg".uiimage)

end