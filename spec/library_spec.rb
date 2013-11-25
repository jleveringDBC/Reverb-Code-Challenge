require_relative 'spec_helper'
require_relative '../model/library'
require_relative '../model/record'

describe Library do

  let(:record1) { Record.new({first_name: "Anna",
                                  last_name: "Kournikova",
                                  middle_initial: "F",
                                  gender: "Female",
                                  birth_date: Date.strptime("6/3/1975", "%m/%d/%Y"),
                                  favorite_color: "Red" } ) }
  let(:record2) { Record.new({first_name: "Timothy",
                                  last_name: "Bishop",
                                  middle_initial: nil,
                                  gender: "Male",
                                  birth_date: Date.strptime("4/23/1967", "%m/%d/%Y"),
                                  favorite_color: "Yellow" } ) }
  let(:new_library) { Library.new() }
  let(:valid_library) { Library.new([record2, record1])}

  describe '#add_record' do
    it 'appropriately adds records' do
      new_library.add_record(record2)
      new_library.add_record(record1)
      expect(new_library.records).to eq valid_library.records
    end
  end

  describe '#sort_by_gender!' do
    it 'appropriately sorts records by gender' do
      valid_library.sort_by_gender!
      expect(valid_library.records).to start_with(record1, record2)
    end
  end

  describe '#sort_by_birth_date!' do
    it 'appropriately sorts records by birth date' do
      valid_library.sort_by_birth_date!
      expect(valid_library.records).to start_with(record2, record1)
    end
  end

  describe '#sort_by_last_name!' do
    it 'appropriately sorts records by last name' do
      valid_library.sort_by_last_name!
      expect(valid_library.records).to start_with(record1, record2)
    end
  end

  describe '#display' do
    it 'displays all records' do
      expect(valid_library.display).to start_with(record2.display)
      expect(valid_library.display).to end_with(record1.display)
    end
  end

end