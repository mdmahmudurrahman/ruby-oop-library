class Book
  attr_reader :id
  attr_reader :title
  attr_reader :author

  def initialize(title, author)
    @title = title
    @author = author
  end
end