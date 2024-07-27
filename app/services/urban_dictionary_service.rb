require 'net/http'

class UrbanDictionaryService
  BASE_URL = 'https://api.urbandictionary.com/v0/define'

  def self.define(term)
    new(term).define
  end

  def initialize(term)
    @term = term
  end

  def define
    response = make_request
    parse_response(response)
  rescue StandardError => e
    Rails.logger.error("Urban Dictionary API error: #{e.message}")
    []
  end

  private

  def make_request
    uri = URI(BASE_URL)
    uri.query = URI.encode_www_form(term: @term)
    response = Net::HTTP.get_response(uri)
    raise "API request failed with status #{response.code}" unless response.is_a?(Net::HTTPSuccess)
    response.body
  end

  def parse_response(response)
    json = JSON.parse(response)
    json['list']
  end
end
