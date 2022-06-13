# example of a class that defines what a Dog object should do and its properties
class Dog  

    def bark  
      'Ruff! Ruff!'  
    end  
  
end

# instantiate a new instance of Dog
myDog = Dog.new()

myDog.bark # returns the string "Ruff! Ruff!"

# a User class that inherit properties from a class called ActiveRecord::Base
class User < ActiveRecord::Base

end

# example of a Terrier class that inherits all properties from Dog class 
# while also having its own properties
class Terrier < Dog

    def bark_the_most 
      'Ruff! Ruff! Ruff! Ruff! Ruff! Ruff! Ruff! Ruff!'  
    end  
  
end

myTerrier = Terrier.new()
myTerrier.bark # returns the string "Ruff! Ruff!"
myTerrier.bark_the_most # returns the string 'Ruff! Ruff! Ruff! Ruff! Ruff! Ruff! Ruff! Ruff!'