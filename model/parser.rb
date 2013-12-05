require_relative 'library'
require_relative 'line_parser'
require_relative 'writer'

class FileParser

  attr_reader :library

  def initialize(library = Library.new, write_file = 'posted_records.txt')
    if library.class != Library
      raise ArgumentError, 'Argument must be a Library'
    else
      @library = library
    end
    @writer = Writer.new(write_file)
  end

  def process_files(filenames)
    filenames.each do |filename|
      read_lines(filename) do |line|
        process_new_record(line)
      end
    end
  end

  def read_lines(filename)
    File.open(filename, 'r') do |f|
      while(line=f.gets)
        yield(line)
      end
    end
  end

  def process_new_record(line)
    lineparser = LineParser.new(line)
    @library.add_record(Record.new(lineparser.line_variables))
  end

  def process_posted_record(line)
    process_new_record(line)
    @writer.append(line)
  end

end