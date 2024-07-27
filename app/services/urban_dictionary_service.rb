require 'net/http'

class UrbanDictionaryService
  BASE_URL = 'https://api.urbandictionary.com/v0/define'

  class NetworkError < StandardError; end
  class NotFoundError < StandardError; end

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
    case response
    when Net::HTTPSuccess
      list = JSON.parse(response.body)['list']
      raise NotFoundError, "No definitions found for '#{@term}'" if list.empty?
      list
    when Net::HTTPNotFound
      raise NotFoundError, "Term '#{@term}' not found"
    else
      raise NetworkError, "API request failed with status #{response.code}"
    end
  end
end
