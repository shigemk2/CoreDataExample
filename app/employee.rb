class Employee < NSManagedObject
  @attributes ||= [['name', NSStringAttributeType, '', false, false, false],
                   ['age', NSInteger32AttributeType, '', false, false, false]]
end
