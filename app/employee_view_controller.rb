class EmployeeViewController < UIViewController
  attr_accessor :managed_object_context
  def loadView
    self.title = 'Employee'

    table_view = UITableView.alloc.initWithFrame(UIScreen.mainScreen.bounds,
                                                 style:UITableViewStyleGrouped)
    table_view.dataSource = self
    self.view = table_view
    add_new_employee_item = UIBarButtonItem.alloc.initWithBarButtonSystemItem(UIBarButtonSystemItemAdd,
                                                                              target: self,
                                                                              action: 'add_new_employee')
    self.navigationItem.rightBarButtonItem = add_new_employee_item
  end

  def viewWillAppear(animated)
    super
    reload_data
  end

  def reload_data
    fetch_request = NSFetchRequest.alloc.init
    entity = NSEntityDescription.entityForName(Employee.name,
                                               inManagedObjectContext:@managed_object_context)
    fetch_request.setEntity(entity)
    fetch_sort = NSSortDescriptor.alloc.initWithKey('name', ascending: true)
    fetch_request.setSortDescriptors([fetch_sort])
    update_fetched_employee_with_fetch_request(fetch_request)
  end

  def update_fetched_employee_with_fetch_request(fetch_request)
    error_pointer = Pointer.new(:object)
@fetched_employee = @managed_object_context.executeFetchRequest(fetch_request,
                                                                error: error_pointer)
    unless @fetched_employee
      raise "Error fetching employee: #{error_pointer[0].description}"
    end
    self.view.reloadData
  end

  def tableView(tableView, numberOfRowsInSection: section)
    @fetched_employee.count
  end

  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    cell_identifier = 'EmployeeCell'
    cell = tableView.dequeueReusableCellWithIdentifier(cell_identifier)
    if cell == nil
cell = UITableViewCell.alloc.initWithStyle(UITableViewCellStyleValue1,
                                           reuseIdentifier:cell_identifier)
      cell.selectionStyle = UITableViewCellSelectionStyleNone
    end

    employee = @fetched_employee[indexPath.row]
    cell.textLabel.text = employee.name
    cell.detailTextLabel.text = employee.age.to_s
    cell
  end

  def add_new_employee
    add_employee_view_controller = AddEmployeeViewController.alloc.init
    add_employee_view_controller.managed_object_context = @managed_object_context

    self.navigationController.pushViewController(add_employee_view_controller, animated:true)
  end
end
