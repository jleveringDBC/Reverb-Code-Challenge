require 'Date'
require_relative 'model/parser'

library = Library.new
parser = Parser.new(library)
filenames = ARGV.map

parser.process(filenames)

library.sort_by_gender!
puts "Output #1:"
puts library.display
puts ""

library.sort_by_birth_date!
puts "Output #2:"
puts library.display
puts ""

library.sort_by_last_name!
puts "Output #3:"
puts library.display