module Menu
  def menu(name)
    print File.read "source/menus/descriptions/#{name}.txt"
    print 'Your choice: '
    gets.chomp
  end

  def list(list, title)
    puts
    puts "All #{title} in the Library:"

    if not list.empty?
      list.each_with_index do |value, index|
        puts "#{index + 1}. #{value.inspect}"
      end
    else
      puts "There is no #{title} in the Library!"
    end
  end

  def file
    name.gsub('Menu', '').downcase
  end

  def run
    @continue = true

    while @continue
      parse menu @file
    end
  end

  def parse(command)
    send @commands[command]
  end

  def commands
    Hash.new :incorrect_command
  end

  def incorrect_command
    puts 'Incorrect command!'
  end

  def back_to_menu
    @continue = false
  end
end