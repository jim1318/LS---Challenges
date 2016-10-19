class Person
  @@total_people = 0
  
  attr_accessor :name, :weight, :height

  def initialize(name, weight, height)
    @name = name
    @weight = weight
    @height = height
    @@total_people +=1
  end

  def self.total_people
    @@total_people
  end
end

bob = Person.new('bob', 185, 70)
p Person.total_people == 1       # this should return 1

#Test getter and setter
bob.name = 'Frank'
bob.weight = 200
bob.height = 88
p bob.name == 'Frank'
p bob.weight == 200
p bob.height == 88