class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    searchController = SearchController.alloc.init
    @window.rootViewController = UINavigationController.alloc.initWithRootViewController(searchController)
    @window.makeKeyAndVisible
    true
  end
end
