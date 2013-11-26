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
      expect(parser.process("pipe_test.txt", "comma_test.txt")).to_not raise_error
    end

    def post_process_expectations(records)
      expect(records.count).to eq(3)
      expect(records.last).to be_a(Record)
      expect(records.last.last_name).to eq("Bouillon")
      expect(records.last.gender).to eq("Male")
      expect(records.last.formatted_birth_date).to eq("06/03/1975")
    end

    context 'when passed pipe delimited records' do

      it 'saves each line as a record in the library' do
        parser.process('pipe_test.txt')
        post_process_expectations(parser.library.records)
      end
    end

    context 'when passed comma delimited records' do
      it 'saves each line as a record in the library' do
        parser.process('comma_test.txt')
        post_process_expectations(parser.library.records)
      end
    end

    context 'when passed space delimited records' do
      it 'saves each line as a record in the library' do
        parser.process('space_test.txt')
        post_process_expectations(parser.library.records)
      end
    end
  end

end