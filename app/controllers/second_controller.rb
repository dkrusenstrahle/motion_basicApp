class SecondController < UIViewController
  def initWithNibName(name, bundle: bundle)
    super
    customize
    self
  end

  def viewDidLoad
    super

    # Create the array to hold the data

    @projects ||= []

    # Create table and add it to the main view

    @table = UITableView.alloc.initWithFrame(self.view.bounds)
    @table.dataSource = self
    self.view.addSubview @table

    # Load data into the table

    populate_table
  end

  def populate_table

    # Make call to API via Modal class method

    Second.fetch_content do |success, projects|
      if success
        @projects = projects
        @table.reloadData
      end
    end
  end

  def tableView(tableView, numberOfRowsInSection:section)

    # Set the amount of rows

    @projects.count
  end

  def tableView(tableView, cellForRowAtIndexPath:indexPath)

    # Get data

    project = @projects[indexPath.row]

    # Dequeue a cell if available

    cell = tableView.dequeueReusableCellWithIdentifier "projects"

    # Create another cell if there is no rows to dequeue

    cell = UITableViewCell.alloc.initWithStyle UITableViewCellStyleDefault, reuseIdentifier:"projects" if cell.nil?

    # Add title to row from response and return the cell

    cell.textLabel.text = project.title
    cell
  end

  def tableView(tableView, didSelectRowAtIndexPath:indexPath)

    # Remove the row highlight after click

    tableView.deselectRowAtIndexPath(indexPath, animated: true)
    controller = TasksController.alloc.init
    controller.refresh_data(@projects[indexPath.row])
    self.navigationController.pushViewController(controller, animated:true)
  end

  def customize

    # Set the main view attributes

    self.title = "Table"
    view.backgroundColor = UIColor.whiteColor 

    # Create the images

    tabNormal = UIImage.imageNamed('tabbar-activity-selected.png')
    tabSelected = UIImage.imageNamed('tabbar-activity-selected.png')

    backNormal = UIImage.imageNamed('nav-backbutton.png').stretchableImageWithLeftCapWidth(14, topCapHeight:0)
    backPressed = UIImage.imageNamed('nav-backbutton.png').stretchableImageWithLeftCapWidth(14, topCapHeight:0)

    # Style the tabBar item

    self.tabBarItem = UITabBarItem.alloc.initWithTitle('Table', image: nil, tag: 0)
    self.tabBarItem.setFinishedSelectedImage(tabSelected, withFinishedUnselectedImage: tabNormal) 

    # Style the back button

    offset = UIOffset.new(3, 0)
    
    UIBarButtonItem.appearance.setBackButtonBackgroundImage(backNormal, forState:UIControlStateNormal, barMetrics:UIBarMetricsDefault)
    UIBarButtonItem.appearance.setBackButtonBackgroundImage(backPressed, forState: UIControlStateHighlighted, barMetrics: UIBarMetricsDefault)
    UIBarButtonItem.appearance.setBackButtonTitlePositionAdjustment(offset, forBarMetrics:UIBarMetricsDefault)
  end
end