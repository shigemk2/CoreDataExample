class NSEntityDescription
  def self.newEntityDescriptionWithName(name, attributes:attributes)
    entity = self.alloc.init
    entity.name = name
    entity.managedObjectClassName = name

    attributes = attributes.each.map do |name, type, default, optional, transient, indexed|
      property = NSAttributeDescription.alloc.init
      property.name name
      property.attributeType = type
      property.defaultValue = default if default != nil
      property.optional = optional
      property.transient = transient
      property.indexed = indexed
      property
    end
    entity.properties = attributes
    entity
  end
end
