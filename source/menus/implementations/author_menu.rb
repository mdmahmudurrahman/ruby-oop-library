require 'entities/library'

require 'menus/menu'

class AuthorMenu < Menu
  def initialize
    super(commands)
  end

  def commands
    commands = super
    commands['1'] = :list_all_authors
    commands['2'] = :add_new_author
    commands['0'] = :back_to_menu
    commands
  end

  def list_all_authors
    list @library.authors, 'Authors'
  end

  def choose_author
    list_all_authors
    puts

    print 'Your choice: '
    choice = gets.chomp

    @library.authors[choice.to_i - 1]
  end

  def add_new_author
    print 'Enter name of the author: '
    name = gets.chomp

    print 'Enter biography of the author: '
    biography = gets.chomp

    @library.add Author.new name, biography
  end

  private :commands
  private :add_new_author
  private :list_all_authors
end