class Employee < NSManagedObject
  @attributes ||= [['name', NSStringAttributeType, '', false, false, false],
                   ['age', NSInteger32AttributeType, 0, false, false, false]]
end
