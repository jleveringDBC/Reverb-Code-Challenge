require_relative 'spec_helper'
require_relative '../model/parser'
require_relative '../model/library'

describe Parser do

  let(:parser) { Parser.new }

  describe '.initialize' do
    it 'takes a library as an argument' do
      expect(Parser.new(Library.new)).to be_a(Parser)
    end

    it 'does not accept a non-Library argument' do
      expect{Parser.new("string")}.to raise_error(ArgumentError, 'Argument must be a Library')
    end

    it 'initializes with empty Library without argument' do
      expect(parser.library).to be_a(Library)
    end
  end

  describe '#process' do
    it 'takes a variable number of arguments' do
      expect(parser.process("pipe.txt", "comma.txt")).to_not raise_error
    end

    context 'when passed pipe delimited records' do
      it 'saves each line as a record in the library' do
        parser.process('pipe.txt')
        records = parser.library.records
        expect(records.count).to eq(3)
        expect(records.last).to be_a(Record)
        expect(records.last.last_name).to eq("Bouillon")
        expect(records.last.gender).to eq("Male")
        expect(records.last.birth_date).to eq(Date.strptime("6-3-1975", "%m-%d-%Y"))
      end
    end
  end
end