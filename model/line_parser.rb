class LineParser

  def initialize(line)
    @line = line
  end

  def line_variables
    record_info = match_data
    parse_record(record_info)
  end

  private

  def delimiter
    if @line.match(/\|/)
      return "pipe"
    elsif @line.match(/,/)
      return "comma"
    else
      return "space"
    end
  end

  def match_data
    if delimiter == "pipe"
      @line.match(/(.*) \| (.*) \| (.*) \| (.*) \| (.*) \| (.*)/)
    elsif delimiter == "comma"
      @line.match(/(.*), (.*), (.*), (.*), (.*)/)
    elsif delimiter == "space"
      @line.match(/(.*) (.*) (.*) (.*) (.*) (.*)/)
    end
  end

  def parse_record(record_info)
    first_name = record_info[2]
    last_name = record_info[1]
    if delimiter == "pipe"
      middle_initial = record_info[3]
      gender = parse_gender(record_info[4])
      birth_date = parse_date(record_info[6], "-")
      favorite_color = record_info[5]
    elsif delimiter == "comma"
      middle_initial = nil
      gender = record_info[3]
      birth_date = parse_date(record_info[5], "/")
      favorite_color = record_info[4]
    elsif delimiter == "space"
      middle_initial = record_info[3]
      gender = parse_gender(record_info[4])
      birth_date = parse_date(record_info[5], "-")
      favorite_color = record_info[6]
    end
    { first_name: first_name, last_name: last_name, middle_initial: middle_initial, gender: gender, birth_date: birth_date, favorite_color: favorite_color }
  end

  def parse_gender(gender)
    gender == "M" ? "Male" : "Female"
  end

  def parse_date(date, date_delimiter)
    Date.strptime(date, "%m#{date_delimiter}%d#{date_delimiter}%Y")
  end

end