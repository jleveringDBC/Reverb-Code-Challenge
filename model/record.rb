class Record

  def initialize(attributes_hash)
    @first_name = attributes_hash[:first_name]
    @last_name = attributes_hash[:last_name]
    @middle_initial = attributes_hash[:middle_initial]
    @gender = attributes_hash[:gender]
    @birth_date = attributes_hash[:birth_date]
    @favorite_color = attributes_hash[:favorite_color]
  end

  def display
    "#{@last_name} #{@first_name} #{@gender} #{@birth_date} #{@favorite_color}"
  end

end