class Order
  attr_reader :book
  attr_reader :reader
  attr_reader :date

  def initialize(book, reader, date)
    @book = book
    @reader = reader
    @date = date
  end
end