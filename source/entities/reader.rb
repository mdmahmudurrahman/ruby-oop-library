class Reader
  attr_reader :name
  attr_reader :email
  attr_reader :city
  attr_reader :street
  attr_reader :house

  def initialize(name, email, city, street, house)
    @name = name
    @email = email
    @city = city
    @street = street
    @house = house
  end
end