class FirstController < UIViewController
  def initWithNibName(name, bundle: bundle)
    super
    customize
    self
  end

  def viewDidLoad
    super
  end

  def customize

    # Set main view attributes

    self.title = "First"
    view.backgroundColor = UIColor.whiteColor 

    # Create images

    tabNormal = UIImage.imageNamed('tabbar-activity-selected.png')
    tabSelected = UIImage.imageNamed('tabbar-activity-selected.png')
    
    buttonNormal = UIImage.imageNamed('nav-button.png')
    buttonPressed = UIImage.imageNamed('nav-button-green.png')

    # Style tabBar item

    self.tabBarItem = UITabBarItem.alloc.initWithTitle('First', image: nil, tag: 0)
    self.tabBarItem.setFinishedSelectedImage(tabSelected, withFinishedUnselectedImage: tabNormal)

    # Create button 

    button = UIBarButtonItem.alloc.init
    button.title = 'Add'
    button.action = 'push'
    button.setBackgroundImage(buttonNormal, forState:UIControlStateNormal, barMetrics:UIBarMetricsDefault)
    button.setBackgroundImage(buttonPressed, forState:UIControlStateHighlighted, barMetrics:UIBarMetricsDefault)
    button.target = self

    # Add button to navigation controller

    self.navigationItem.rightBarButtonItem = button
  end

  def push

    # Create the controller

    controller = SecondController.alloc.init

    # Push the new controller onto the stack

    self.navigationController.pushViewController(controller, animated:true)
  end
end