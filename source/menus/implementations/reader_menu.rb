require 'entities/library'

require 'menus/menu'

module ReaderMenu
  extend Menu

  @file = file
  @continue = true
  @library = Library.instance

  def self.commands
    commands = super
    commands['1'] = :list_all_readers
    commands['2'] = :add_new_reader
    commands['0'] = :back_to_menu
    commands
  end

  @commands = commands

  def self.list_all_readers
    list @library.readers, 'Readers'
  end

  def self.choose_reader
    list_all_readers
    puts

    print 'Your choice: '
    choice = gets.chomp

    @library.readers[choice.to_i - 1]
  end

  def self.add_new_reader
    print 'Enter name of the reader: '
    name = gets.chomp

    print 'Enter email of the reader: '
    email = gets.chomp

    print 'Enter city where reader lives: '
    city = gets.chomp

    print 'Enter street where reader lives: '
    street = gets.chomp

    print 'Enter house where reader lives: '
    house = gets.chomp

    @library.add Reader.new name, email, city, street, house
  end

  private_class_method :commands
  private_class_method :add_new_reader
  private_class_method :list_all_readers
end