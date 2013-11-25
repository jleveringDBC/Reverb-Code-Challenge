require_relative 'record'

class Library

  attr_reader :records

  def initialize(record_array = [])
    @records = record_array
  end

  def add_record(record)
    @records << record
  end

  def sort_by_gender!
    @records.sort! { |a, b| a.gender == b.gender ?
                      a.last_name <=> b.last_name :
                      a.gender <=> b.gender }
  end

  def sort_by_birth_date!
    @records.sort! { |a, b| a.birth_date <=> b.birth_date }
  end

  def sort_by_last_name!
    @records.sort_by!{ |record| record.last_name }.reverse!
  end

  def display
    result = ""
    @records.each do |record|
      result += record.display
      result += "\n" unless record == @records.last
    end
    result
  end

end