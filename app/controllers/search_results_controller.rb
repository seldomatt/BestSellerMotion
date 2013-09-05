class SearchResultsController < UIViewController

  stylesheet :search_results

  def initWithResults(results, query: query, andScope: scope)
    init.tap do
      @results = results
      @query = query
      @scope = scope
      @iterator = 0
      self.title = "Results"
    end
  end

  layout :root do
    @table = subview(UITableView, :results_table, delegate: self, dataSource: self)
    @table.addInfiniteScrollingWithActionHandler(lambda { load_more_results })
  end

  def layoutDidLoad
    setup_navbar
    App.alert("No search results") if @results.empty?
    @table.registerClass(SearchResultsTableViewCell, forCellReuseIdentifier: "cell_identifier")
  end

  #infinite scrolling
  def load_more_results
    @iterator +=1
    BestSellerApi.search(@query, @scope, offset="#{20*@iterator}") do |data, error|
      if error
        App.alert(error)
      else
        @table.showsInfiniteScrolling = false if data["results"].empty?
        unless data["results"].empty?
          @table.beginUpdates
          start_index = @results.size
          @results += data["results"]
          index_paths = (start_index...@results.size).collect do |i|
            NSIndexPath.indexPathForRow(i, inSection: 0)
          end
          @table.insertRowsAtIndexPaths(index_paths, withRowAnimation: UITableViewRowAnimationTop)
          @table.endUpdates
        end
      end
      @table.infiniteScrollingView.stopAnimating
    end
  end

  #tableView dataSource protocols
  def tableView(tableView, numberOfRowsInSection: section)
    @results.length
  end

  def tableView(tableView, heightForRowAtIndexPath: indexPath)
    105
  end

  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    tableView.dequeueReusableCellWithIdentifier("cell_identifier", forIndexPath: indexPath).tap do |cel|
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
    normalized = split.map { |word| word.capitalize }
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