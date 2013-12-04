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
    raise ArgumentError, 'filenames must respond to each' unless filenames.respond_to?(:each)
    filenames.each do |filename|
      File.open(filename, 'r') do |f|
        while (line = f.gets)
          process_new_record(line)
        end
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