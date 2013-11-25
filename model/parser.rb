class Parser

  attr_reader :library

  def initialize(library = Library.new)
    if library.class != Library
      raise ArgumentError, 'Argument must be a Library'
    else
      @library = library
    end
  end

end