class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    self.setting_core_data
    true
  end

  def setting_core_data
    managed_object_model = NSManagedObjectModel.alloc.init
    # managed_object_model.entities = [Employee.entity]

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
