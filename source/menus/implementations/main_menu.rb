require 'singleton'

require 'menus/menu'

require 'menus/implementations/book_menu'
require 'menus/implementations/author_menu'
require 'menus/implementations/order_menu'
require 'menus/implementations/reader_menu'

class MainMenu < Menu
  def initialize
    super(commands)
  end

  def commands
    commands = super
    commands['1'] = :to_book_menu
    commands['2'] = :to_author_menu
    commands['3'] = :to_reader_menu
    commands['4'] = :to_order_menu
    commands['5'] = :save_library
    commands['6'] = :generate_library

    commands['7'] = :who_often_takes_the_book
    commands['8'] = :what_is_the_most_popular_book
    commands['9'] = :how_many_people_ordered_one_of_the_three_most_popular_books

    commands['0'] = :back_to_menu
    commands
  end

  def to_book_menu
    BookMenu.run
  end

  def to_author_menu
    AuthorMenu.run
  end

  def to_order_menu
    OrderMenu.run
  end

  def to_reader_menu
    ReaderMenu.run
  end

  def save_library
    @library.save
  end

  def generate_library
    author1 = Author.new 'Author 1', 'Biography 1'
    author2 = Author.new 'Author 2', 'Biography 2'
    author3 = Author.new 'Author 3', 'Biography 3'
    @library.add author1, author2, author3

    book1 = Book.new 'Title 1', author1
    book2 = Book.new 'Title 2', author2
    book3 = Book.new 'Title 3', author3
    @library.add book1, book2, book3

    reader1 = Reader.new 'Reader 1', 'Email 1', 'City 1', 'Street 1', 'House 1'
    reader2 = Reader.new 'Reader 2', 'Email 2', 'City 2', 'Street 2', 'House 2'
    reader3 = Reader.new 'Reader 3', 'Email 3', 'City 3', 'Street 3', 'House 3'
    reader4 = Reader.new 'Reader 4', 'Email 4', 'City 4', 'Street 4', 'House 4'
    reader5 = Reader.new 'Reader 5', 'Email 5', 'City 5', 'Street 5', 'House 5'
    @library.add reader1, reader2, reader3, reader4, reader5

    order1 = Order.new book1, reader1, '19-04-2016'
    order2 = Order.new book1, reader1, '18-04-2016'
    order3 = Order.new book1, reader2, '26-04-2036'

    order6 = Order.new book2, reader1, '12-04-2046'
    order7 = Order.new book2, reader2, '12-04-2046'
    order4 = Order.new book2, reader3, '09-04-2026'
    order5 = Order.new book2, reader4, '12-04-2046'

    order8 = Order.new book3, reader1, '12-04-2046'
    order9 = Order.new book3, reader2, '12-04-2046'
    order10 = Order.new book3, reader3, '12-04-2046'
    order11 = Order.new book3, reader4, '12-04-2046'
    order12 = Order.new book3, reader4, '12-04-2046'

    @library.add order1, order2, order3, order4, order5,
                 order6, order7, order8, order9, order10,
                 order11, order12
  end

  def who_often_takes_the_book
    if (book = BookMenu.instance.choose_book)
      reader = @library.who_often_takes_the_book book
      puts "Who often takes the Book: #{reader.inspect}" if reader
    end
  end

  def what_is_the_most_popular_book
    book = @library.what_is_the_most_popular_book
    puts "What is the most popular Book : #{book.inspect}" if book
  end

  def how_many_people_ordered_one_of_the_three_most_popular_books
    readers = @library.how_many_people_ordered_one_of_the_three_most_popular_books

    if readers
      readers.each_with_index do |reader, index|
        puts "#{index + 1}. #{reader.inspect}"
      end
    end
  end

  private :commands
  private :to_book_menu
  private :to_author_menu
  private :to_order_menu
  private :to_reader_menu

  private :save_library
  private :generate_library

  private :who_often_takes_the_book
  private :what_is_the_most_popular_book
  private :how_many_people_ordered_one_of_the_three_most_popular_books
end