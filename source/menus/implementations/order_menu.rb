require 'entities/library'

require 'menus/menu'

require 'menus/implementations/book_menu'
require 'menus/implementations/reader_menu'

module OrderMenu
  extend Menu

  @file = file
  @continue = true
  @library = Library.instance

  def self.commands
    commands = super
    commands['1'] = :list_all_orders
    commands['2'] = :add_new_order
    commands['0'] = :back_to_menu
    commands
  end

  @commands = commands

  def self.list_all_orders
    list @library.orders, 'Orders'
  end

  def self.add_new_order
    book = BookMenu.choose_book
    reader = ReaderMenu.choose_reader

    print 'Enter the date: '
    date = gets.chomp

    @library.add_order Order.new book, reader, date if book and reader
  end

  private_class_method :commands
  private_class_method :add_new_order
  private_class_method :list_all_orders
end