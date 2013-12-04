require 'grape'
require_relative 'model/parser'

module RecordParser
  class API < Grape::API

    helpers do
      def new_parser
        if $write_file
          fresh_parser = FileParser.new(Library.new, $write_file)
        else
          fresh_parser = FileParser.new
        end
        fresh_parser.process_files($filenames)
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
      params do
        requires :record, type: String, desc: "Record to be added."
      end
      post do
        parser.process_posted_record(params[:record])
        return "Added the new record!"
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