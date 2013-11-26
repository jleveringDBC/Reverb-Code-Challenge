require 'grape'

module RecordParser
  class API < Grape::API

    format :json

    resources :records do

      desc 'adds record to library'
      post do
        return "Added a record!"
      end

      desc 'returns records sorted by gender'
      get :gender do
        return "Gender List!"
      end

      desc 'returns records sorted by birthdate'
      get :birthdate do
        return "Birth Date List!"
      end

      desc 'returns records sorted by last name'
      get :name do
        return "Last Name List!"
      end

    end
  end
end