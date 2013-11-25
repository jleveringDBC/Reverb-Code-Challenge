class Parser

  attr_reader :library

  def initialize(library = Library.new)
    if library.class != Library
      raise ArgumentError, 'Argument must be a Library'
    else
      @library = library
    end
  end

  def process(*filenames)
    filenames.each do |filename|
      File.open(filename, 'r') do |f|
        while (line = f.gets)
          if line.match(/\|/)
            record_info = line.match(/(.*) \| (.*) \| (.*) \| (.*) \| (.*) \| (.*)/)
            first_name = record_info[2]
            last_name = record_info[1]
            middle_initial = record_info[3]
            record_info[4] == "M" ? gender = "Male" : gender = "Female"
            birth_date = Date.strptime(record_info[6], "%m-%d-%Y")
            favorite_color = record_info[5]
            @library.add_record(Record.new( { first_name: first_name,
                                          last_name: last_name,
                                          middle_initial: middle_initial,
                                          gender: gender,
                                          birth_date: birth_date,
                                          favorite_color: favorite_color } ) )
          elsif line.match(/,/)
            record_info = line.match(/(.*), (.*), (.*), (.*), (.*)/)
            first_name = record_info[2]
            last_name = record_info[1]
            gender = record_info[3]
            birth_date = Date.strptime(record_info[5], "%m/%d/%Y")
            favorite_color = record_info[4]
            @library.add_record(Record.new( { first_name: first_name,
                                          last_name: last_name,
                                          gender: gender,
                                          birth_date: birth_date,
                                          favorite_color: favorite_color } ) )
          else
            record_info = line.match(/(.*) (.*) (.*) (.*) (.*) (.*)/)
            first_name = record_info[2]
            last_name = record_info[1]
            middle_initial = record_info[3]
            record_info[4] == "M" ? gender = "Male" : gender = "Female"
            birth_date = Date.strptime(record_info[5], "%m-%d-%Y")
            favorite_color = record_info[6]
            @library.add_record(Record.new( { first_name: first_name,
                                          last_name: last_name,
                                          middle_initial: middle_initial,
                                          gender: gender,
                                          birth_date: birth_date,
                                          favorite_color: favorite_color } ) )
          end
        end
      end
    end
  end

end