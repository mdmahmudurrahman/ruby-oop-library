require 'entities/library'

require 'menus/menu'

require 'menus/implementations/book_menu'
require 'menus/implementations/reader_menu'

class OrderMenu < Menu
  def initialize
    super(commands)
  end

  def commands
    commands = super
    commands['1'] = :list_all_orders
    commands['2'] = :add_new_order
    commands['0'] = :back_to_menu
    commands
  end

  def list_all_orders
    list @library.orders, 'Orders'
  end

  def add_new_order
    book = BookMenu.instance.choose_book
    reader = ReaderMenu.instance.choose_reader

    print 'Enter the date: '
    date = gets.chomp

    @library.add Order.new book, reader, date if book and reader
  end

  private :commands
  private :add_new_order
  private :list_all_orders
end