require 'entities/library'

require 'menus/menu'

require 'menus/implementations/author_menu'

class BookMenu < Menu
  def initialize
    super(commands)
  end

  def commands
    commands = super
    commands['1'] = :list_all_books
    commands['2'] = :add_new_book
    commands['0'] = :back_to_menu
    commands
  end

  def list_all_books
    list @library.books, 'Books'
  end

  def add_new_book
    print 'Enter title of the book: '
    title = gets.chomp
    author = AuthorMenu.instance.choose_author

    @library.add Book.new title, author if author
  end

  def choose_book
    list_all_books
    puts

    print 'Your choice: '
    choice = gets.chomp

    @library.books[choice.to_i - 1]
  end

  private :commands
  private :add_new_book
  private :list_all_books
end