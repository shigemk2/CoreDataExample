class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    self.setting_core_data
    # employee_view_controller = EmployeeViewController.alloc.init
    # employee_view_controller.managed_object_context = @managed_object_context
    # @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    # @window.rootViewController = UINavigationController.alloc.initWithRootViewController(employee_view_controller)
    # @window.makeKeyAndVisible
    true
  end

  def setting_core_data
    managed_object_model = NSManagedObjectModel.alloc.init
    managed_object_model.entities = [Employee.entity]

    persistent_store_coordinator = NSPersistentStoreCoordinator.alloc.initWithManagedObjectModel(managed_object_model)

    persistent_store_file_url = NSURL.fileURLWithPath(File.join(NSHomeDirectory(),
                                                                'Documents',
                                                                'EmployeeStore.sqlite'))
    error_pointer = Pointer.new(:object)

    unless
        persistent_store_coordinator.addPersistentStoreWithType(NSSQLiteStoreType,
                                                                configuration: nil,
                                                                URL: persistent_store_file_url,
                                                                options: nil,
                                                                error: error_pointer)
      raise "Cannot initialize Core Data Persistance Store Coordinator: #{error_pointer[0].description}"
    end
    @managed_object_context = NSManagedObjectContext.alloc.init
    @managed_object_context.persistentStoreCoordinator = persistent_store_coordinator
  end
end
