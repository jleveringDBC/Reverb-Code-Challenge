class Writer

  def initialize(filename)
    @filename = filename
  end

  def append(line)
    File.open(@filename, 'a') { |f| f.puts line }
  end

end