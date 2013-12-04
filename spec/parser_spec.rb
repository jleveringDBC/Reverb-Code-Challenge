require_relative 'spec_helper'
require_relative '../model/parser'

describe FileParser do

  let(:parser) { FileParser.new }

  describe '.initialize' do
    it 'takes a library as an argument' do
      expect(FileParser.new(Library.new)).to be_a(FileParser)
    end

    it 'does not accept a non-Library argument' do
      expect{FileParser.new("string")}.to raise_error(ArgumentError, 'Argument must be a Library')
    end

    it 'initializes an empty Library without argument' do
      expect(parser.library).to be_a(Library)
    end
  end

  describe '#process_files' do
    it 'takes a an array as argument' do
      expect(parser.process_files(["spec/examples/pipe_test.txt", "spec/examples/comma_test.txt"])).to_not raise_error
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
        parser.process_files(['spec/examples/pipe_test.txt'])
        post_process_expectations(parser.library.records)
      end
    end

    context 'when passed comma delimited records' do
      it 'saves each line as a record in the library' do
        parser.process_files(['spec/examples/comma_test.txt'])
        post_process_expectations(parser.library.records)
      end
    end

    context 'when passed space delimited records' do
      it 'saves each line as a record in the library' do
        parser.process_files(['spec/examples/space_test.txt'])
        post_process_expectations(parser.library.records)
      end
    end
  end


  describe '#process_new_record' do
    it 'adds a new record to the library' do
      parser.process_new_record("Bouillon Francis G M 6-3-1975 Blue")
      record = parser.library.records.last
      expect(record.first_name).to eq "Francis"
      expect(record.gender).to eq "Male"
      expect(record.formatted_birth_date).to eq "06/03/1975"
    end
  end

  describe '#process_posted_record' do
    it 'writes new record to file' do
      parser.process_posted_record("Levering Joseph W M 12-18-1986 Black")
      expect(`tail -n 1 posted_records.txt`).to eq ("Levering Joseph W M 12-18-1986 Black\n")
    end
  end

end