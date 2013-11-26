require 'grape'
require_relative 'model/parser'

module RecordParser
  class API < Grape::API

    helpers do
      def new_parser
        fresh_parser = Parser.new
        fresh_parser.process(["pipe.txt", "comma.txt", "space.txt"])
        fresh_parser
      end

      def parser
        @parser ||= new_parser
      end

      def library
        parser.library
      end
    end

    format :txt

    resources :records do

      desc 'adds record to library'
      post do
        return "Added a record!"
      end

      desc 'returns records sorted by gender'
      get :gender do
        library.sort_by_gender!
        return library.display
      end

      desc 'returns records sorted by birthdate'
      get :birthdate do
        library.sort_by_birth_date!
        return library.display
      end

      desc 'returns records sorted by last name'
      get :name do
        library.sort_by_last_name!
        return library.display
      end

    end
  end
end