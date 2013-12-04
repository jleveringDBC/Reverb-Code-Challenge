require 'rack/test'
require 'open-uri'
require_relative 'spec_helper'
require_relative '../API'
include RecordParser::API::helpers

$filenames = ["pipe.txt", "comma.txt", "space.txt", "posted_records.txt"]

describe RecordParser::API do
  include Rack::Test::Methods

  def app
    RecordParser::API
  end

  def get_expectations
    expect(last_response.body).to eq(parser.library.display)
  end

  let (:parser) { new_parser }
  let (:record) { "Hendrix | Jimi | M | M | Purple | 11-27-1942" }
  let (:encoded_record) { URI::encode(record) }

  describe 'POST /records' do
    it 'returns success message' do
      post "/records", "record=#{encoded_record}"
      expect(last_response.body).to eq("Added the new record!")
      expect(last_response.status).to eq(201)
    end

    it 'returns 400 when passed unspecified param' do
      post "/records", encoded_record
      expect(last_response.status).to eq(400)
    end

    it 'writes to specified file' do
      $write_file = 'new_records.txt'
      post "/records", "record=#{encoded_record}"
      expect(`tail -n 1 new_records.txt`).to eq("#{record}\n")
    end

  end

  describe 'GET /records/gender' do
    before do
      parser.library.sort_by_gender!
    end
    it 'returns records sorted by gender' do
      get "/records/gender"
      get_expectations
    end
  end

  describe 'GET /records/birthdate' do
    before do
      parser.library.sort_by_birth_date!
    end
    it 'returns records sorted by birth date' do
      get "/records/birthdate"
      get_expectations
    end
  end

  describe 'GET /records/name' do
    before do
      parser.library.sort_by_last_name!
    end
    it 'returns records sorted by last name' do
      get "/records/name"
      get_expectations
    end
  end

end