require_relative 'spec_helper'
require_relative '../model/parser'
require_relative '../model/library'

describe Parser do

  describe '.initialize' do
    it 'takes a library as an argument' do
      expect(Parser.new(Library.new)).to be_a(Parser)
    end

    it 'does not accept a non-Library argument' do
      expect{Parser.new("string")}.to raise_error(ArgumentError, 'Argument must be a Library')
    end

    it 'initializes with empty Library without argument' do
      expect(Parser.new.library).to be_a(Library)
    end
  end
end