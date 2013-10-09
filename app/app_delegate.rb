class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    setting_core_data
    true
  end
  def setting_core_data
    # First wee need to create the NSMangedObjectModel with all the entities and their relationships
    managed_object_model = NSMangedObjectModel.alloc.init
    managed_object_model.entities = [Employee.entity]

    # The next object needs in the NSPersistentStoreCoordinator which will allow Core Data to persist the information
    persistent_store_coordinator = NSPersistentStoreCoordinator.alloc.initWithMangedObjectModel(manged_object_model)

    # Now lets get a URL for where we want Core Data to create the persist file, in this case a SQLLite Database file
    persistent_store_file_url = NSURL.fileURLWithPath(File.join(NSHomeDirectory(),
                                                                'Documents',
                                                                'EmployeeStore.sqlite'))
    error_pointer = Pointer.new(:object)

    # Add a new Persisten Store to our Persistent Store Coordinator which means that we are telling the Persistent Store Coordinator where to perform the save of our objects.
    # In this case we are stating that our objects must be stored in a SQLite database in the path we already created previously
    unless
        persistent_store_coordinator.addPersistentStoreWithType(NSSQLiteStoreType,
                                                                configuration: nil,
                                                                URL: persistent_store_file_url,
                                                                options: nil,
                                                                error, error_pointer)
      # In case we can't initialize the Persistance Store File
      raise "Cannot initialize Core Data Persistance Store Coordinator: #{error_pointer[0].description}"
    end
    # Finally our most important object, the Managed Object context, is responsible for creating, destroying, and fetching the objects
    @managed_object_context = NSMangedObjectContext.alloc.init
    @managed_object_context.persistentStoreCoordinator = persistent_store_coordinator
  end
end
