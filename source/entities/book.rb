class Book
  attr_reader :title
  attr_reader :author

  def initialize(title, author)
    @title, @author = title, author
  end
end