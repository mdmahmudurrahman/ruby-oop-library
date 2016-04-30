require 'entities/library'

require 'menus/menu'

module AuthorMenu
  extend Menu

  @file = file
  @continue = true
  @library = Library.instance

  def self.commands
    commands = super
    commands['1'] = :list_all_authors
    commands['2'] = :add_new_author
    commands['0'] = :back_to_menu
    commands
  end

  @commands = commands

  def self.list_all_authors
    list @library.authors, 'Authors'
  end

  def self.choose_author
    list_all_authors
    puts

    print 'Your choice: '
    choice = gets.chomp

    @library.authors[choice.to_i - 1]
  end

  def self.add_new_author
    print 'Enter name of the author: '
    name = gets.chomp

    print 'Enter biography of the author: '
    biography = gets.chomp

    @library.add_author Author.new name, biography
  end

  private_class_method :commands
  private_class_method :add_new_author
  private_class_method :list_all_authors
end