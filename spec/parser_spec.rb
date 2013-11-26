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
    it 'takes a an array as argument' do
      expect(parser.process(["pipe_test.txt", "comma_test.txt"])).to_not raise_error
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
        parser.process(['pipe_test.txt'])
        post_process_expectations(parser.library.records)
      end
    end

    context 'when passed comma delimited records' do
      it 'saves each line as a record in the library' do
        parser.process(['comma_test.txt'])
        post_process_expectations(parser.library.records)
      end
    end

    context 'when passed space delimited records' do
      it 'saves each line as a record in the library' do
        parser.process(['space_test.txt'])
        post_process_expectations(parser.library.records)
      end
    end
  end

  describe '#delimiter' do
    it 'returns "pipe" when | is present' do
      expect(parser.send(:delimiter, "Pipe | Example")).to eq("pipe")
    end

    it 'returns "comma" when , is present' do
      expect(parser.send(:delimiter, "Comma, Example")).to eq("comma")
    end

    it 'returns "space" when | and , are not present' do
      expect(parser.send(:delimiter, "Space Example")).to eq("space")
    end
  end

  describe '#match_data' do
    it 'returns match data when given "pipe" as delimiter' do
      match = parser.send(:match_data, "Bouillon | Francis | G | M | Blue | 6-3-1975", "pipe")
      expect(match[2]).to eq "Francis"
    end

    it 'returns match data when given "comma" as delimiter' do
      match = parser.send(:match_data, "Bouillon, Francis, Male, Blue, 6/3/1975", "comma")
      expect(match[2]).to eq "Francis"
    end

    it 'returns match data when given "space" as delimiter' do
      match = parser.send(:match_data, "Bouillon Francis G M 6-3-1975 Blue", "space")
      expect(match[2]).to eq "Francis"
    end

  end

end