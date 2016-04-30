module Parser
  def read
    begin
      File.open 'data/library.data', 'r' do |file|
        Marshal.load file
      end
    rescue Exception
      return Hash.new { |hash, key| hash[key] = Array.new }
    end
  end

  def write(data)
    begin
      File.open 'data/library.data', 'wb' do |file|
        Marshal.dump data, file if data
      end
    rescue Exception
      puts 'Error while saving library to file!'
    end
  end

  private :read, :write
end