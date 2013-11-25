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

    def post_process_expectations(records)
      expect(records.count).to eq(3)
      expect(records.last).to be_a(Record)
    end

    context 'when passed pipe delimited records' do

      it 'saves each line as a record in the library' do
        parser.process('pipe.txt')
        records = parser.library.records
        post_process_expectations(records)
        expect(records.last.last_name).to eq("Bouillon")
        expect(records.last.gender).to eq("Male")
        expect(records.last.birth_date).to eq(Date.strptime("6-3-1975", "%m-%d-%Y"))
      end
    end

    context 'when passed comma delimited records' do
      it 'saves each line as a record in the library' do
        parser.process('comma.txt')
        records = parser.library.records
        post_process_expectations(records)
        expect(records.last.last_name).to eq("Kelly")
        expect(records.last.gender).to eq("Female")
        expect(records.last.birth_date).to eq(Date.strptime("7/12/1959", "%m/%d/%Y"))
      end
    end

    context 'when passed space delimited records' do
      it 'saves each line as a record in the library' do
        parser.process('space.txt')
        records = parser.library.records
        post_process_expectations(records)
        expect(records.last.last_name).to eq("Seles")
        expect(records.last.gender).to eq("Female")
        expect(records.last.birth_date).to eq(Date.strptime("12-2-1973", "%m-%d-%Y"))
      end
    end
  end
end