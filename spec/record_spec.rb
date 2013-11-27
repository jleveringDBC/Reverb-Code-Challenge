require_relative 'spec_helper'
require_relative '../model/record'

describe Record do

  let(:valid_record) { Record.new({first_name: "Anna",
                                    last_name: "Kournikova",
                                    middle_initial: "F",
                                    gender: "Female",
                                    birth_date: Date.strptime("6-3-1975", "%m-%d-%Y"),
                                    favorite_color: "Red" } ) }

  describe '#display' do

    it 'displays attributes in order' do
      expect(valid_record.display).to eq("Kournikova Anna Female 06/03/1975 Red")
    end

  end

end