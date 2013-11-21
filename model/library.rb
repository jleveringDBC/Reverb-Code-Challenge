require_relative 'record'

class Library

  attr_reader :records

  def initialize()
    @records = []
  end

  def add_record(record)
    @records << record
  end

end