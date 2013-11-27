require_relative 'library'

class Parser

  attr_reader :library

  def initialize(library = Library.new, write_file = 'posted_records.txt')
    if library.class != Library
      raise ArgumentError, 'Argument must be a Library'
    else
      @library = library
    end
    @write_file = write_file
  end

  def process(filenames)
    raise ArgumentError, 'Pass filenames in Array' unless [Array, Enumerator].include?(filenames.class)
    filenames.each do |filename|
      File.open(filename, 'r') do |f|
        while (line = f.gets)
          add_record_to_library(line)
        end
      end
    end
  end

  def process_new_record(line)
    add_record_to_library(line)
    File.open(@write_file, 'a') do |f|
      f.puts line
    end
  end

  private

  def add_record_to_library(line)
    delimiter = delimiter(line)
    record_info = match_data(line, delimiter)
    record_variables = parse_record(record_info, delimiter)
    @library.add_record(Record.new(record_variables))
  end

  def delimiter(line)
    if line.match(/\|/)
      return "pipe"
    elsif line.match(/,/)
      return "comma"
    else
      return "space"
    end
  end

  def match_data(line, delimiter)
    if delimiter == "pipe"
      line.match(/(.*) \| (.*) \| (.*) \| (.*) \| (.*) \| (.*)/)
    elsif delimiter == "comma"
      line.match(/(.*), (.*), (.*), (.*), (.*)/)
    elsif delimiter == "space"
      line.match(/(.*) (.*) (.*) (.*) (.*) (.*)/)
    end
  end

  def parse_record(record_info, delimiter)
    first_name = record_info[2]
    last_name = record_info[1]
    if delimiter == "pipe"
      middle_initial = record_info[3]
      record_info[4] == "M" ? gender = "Male" : gender = "Female"
      birth_date = Date.strptime(record_info[6], "%m-%d-%Y")
      favorite_color = record_info[5]
    elsif delimiter == "comma"
      middle_initial = nil
      gender = record_info[3]
      birth_date = Date.strptime(record_info[5], "%m/%d/%Y")
      favorite_color = record_info[4]
    elsif delimiter == "space"
      middle_initial = record_info[3]
      record_info[4] == "M" ? gender = "Male" : gender = "Female"
      birth_date = Date.strptime(record_info[5], "%m-%d-%Y")
      favorite_color = record_info[6]
    end
    { first_name: first_name, last_name: last_name, middle_initial: middle_initial, gender: gender, birth_date: birth_date, favorite_color: favorite_color }
  end

end