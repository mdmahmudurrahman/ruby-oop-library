class Author
  attr_reader :name
  attr_reader :biography

  def initialize(name, biography)
    @name, @biography = name, biography
  end
end