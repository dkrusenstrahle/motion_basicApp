class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)

    # Create the main window

    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.makeKeyAndVisible

    # Create the main controllers

    first = FirstController.alloc.initWithNibName(nil, bundle: nil)
    second = SecondController.alloc.initWithNibName(nil, bundle: nil)

    # Create the main navigation controllers

    first_nav = UINavigationController.alloc.initWithRootViewController(first)
    second_nav = UINavigationController.alloc.initWithRootViewController(second)

    # Style the navBar

    backgroundImage = UIImage.imageNamed('navigationbar.png') 
    
    first_nav.navigationBar.setBackgroundImage(backgroundImage, forBarMetrics:UIBarMetricsDefault)
    second_nav.navigationBar.setBackgroundImage(backgroundImage, forBarMetrics:UIBarMetricsDefault)

    # Style the tabBar

    tabBarController = UITabBarController.alloc.initWithNibName(nil, bundle: nil)
    tabBarController.tabBar.backgroundImage = UIImage.imageNamed('tabbar-background.png')
    tabBarController.tabBar.selectionIndicatorImage = UIImage.imageNamed('tabbar-background-pressed.png')

    # Add the tabs

    tabBarController.viewControllers = [first_nav, second_nav]

    # Set root controller for the window

    @window.rootViewController = tabBarController

    true
  end
end
