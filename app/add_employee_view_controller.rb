class AddEmployeeViewController < UIViewController
  attr_accessor :managed_object_context

  def viewDidLoad
    self.view.backgroundColor = UIColor.whiteColor
    self.title = 'Add Employee'
    save_bar_button_item = UIBarButtonItem.alloc.initWithTitle('Save',
                                                               style: UIBarButtonItemStyleDone,
                                                               target: self,
                                                               action: 'save_employee')
    self.navigationItem.rightBarButtonItem = save_bar_button_item
    load_form
  end

  def save_employee
    employee = NSEntityDescription.insertNewObjectForEntityForName(Employee.name,
                                                                   inManagedObjectContext: @managed_object_context)
    employee.name = @name.text
    employee.age = @age.text.intValue

    error_pointer = Pointer.new(:object)

    unless @managed_object_context.save(error_pointer)
      raise "Error saving a new Director: #{error_pointer[0].description}"
    end

    self.navigationController.popViewControllerAnimated(true)
  end

  def load_form
    @name = UITextField.alloc.initWithFrame([[50,100],[200,30]])
    @name.borderStyle = UITextBorderStyleRoundedRect
    @name.placeholder = "Name"
    self.view.addSubview(@name)

    @age = UITextField.alloc.initWithFrame([[50,150],[200,30]])
    @age.borderStyle = UITextBorderStyleRoundedRect
    @age.placeholder = "Age"
    self.view.addSubview(@age)

  end
end
