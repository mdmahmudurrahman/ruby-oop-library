require 'entities/library'

require 'menus/menu'
require 'menus/implementations/author_menu'

module BookMenu
  extend Menu

  @file = file
  @continue = true
  @library = Library.instance

  def self.commands
    commands = super
    commands['1'] = :list_all_books
    commands['2'] = :add_new_book
    commands['0'] = :back_to_menu
    commands
  end

  @commands = commands

  def self.list_all_books
    list @library.books, 'Books'
  end

  def self.add_new_book
    print 'Enter title of the book: '
    title = gets.chomp
    author = AuthorMenu.choose_author

    @library.add Book.new title, author if author
  end

  def self.choose_book
    list_all_books
    puts

    print 'Your choice: '
    choice = gets.chomp

    @library.books[choice.to_i - 1]
  end

  private_class_method :commands
  private_class_method :add_new_book
  private_class_method :list_all_books
end