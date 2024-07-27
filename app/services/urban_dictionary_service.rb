require 'net/http'

class UrbanDictionaryService
  BASE_URL = 'https://api.urbandictionary.com/v0/define'

  class NetworkError < StandardError; end

  def self.define(term)
    new(term).define
  end

  def initialize(term)
    @term = term
  end

  def define
    response = make_request
    parse_response(response)
  end

  private

  def make_request
    uri = URI(BASE_URL)
    uri.query = URI.encode_www_form(term: @term)
    Net::HTTP.get_response(uri)
  end

  def parse_response(response)
    raise NetworkError, "API request failed with status #{response.code}" unless response.is_a? Net::HTTPSuccess

    json = JSON.parse(response.body)
    json['list']
  end
end
