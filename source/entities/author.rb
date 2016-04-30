class Author
  attr_reader :id
  attr_reader :name
  attr_reader :biography

  def initialize(name, biography)
    @name = name
    @biography = biography
  end
end