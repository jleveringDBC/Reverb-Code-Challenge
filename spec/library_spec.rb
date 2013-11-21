require_relative 'spec_helper'
require_relative '../model/library'

describe Library do

  let(:valid_library) { Library.new() }

  describe '#add_record' do
    it 'appropriately adds records' do
      valid_library.add_record(Record.new({}))
      valid_library.add_record(Record.new({}))
      expect(valid_library.records.count).to eq 2
    end
  end

  describe '#sort_by_gender' do
  end

  describe '#sort_by_birth_date' do
  end

  describe '#sort_by_last_name' do
  end

end