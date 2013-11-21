require_relative 'spec_helper'
require_relative '../model/record'

describe Record do

  describe '#display' do
    let(:valid_record) { Record.new({first_name: "Anna",
                                    last_name: "Kournikova",
                                    middle_initial: "F",
                                    gender: "Female",
                                    birth_date: "6/3/1975",
                                    favorite_color: "Red" } ) }

    it 'displays attributes in appropriate order' do
      expect(valid_record.display).to eq("Kournikova Anna Female 6/3/1975 Red")
    end

  end

end