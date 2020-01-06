# frozen_string_literal: true

require "uri"
require "net/http"
require "json"

module AcademicSearch
  extend ActiveSupport::Concern

  class_methods do
    # Search by Academic Search API
    # @return [Hash] json parsed objects
    #
    # @note This method use SUBSCRIPTION_KEY environment variable.
    def search_api(expr)
      uri = URI.parse("https://api.labs.cognitive.microsoft.com/academic/v1.0/evaluate?expr=#{expr}&attributes=Id")
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true

      response = http.get(uri.request_uri, {"Ocp-Apim-Subscription-Key": ENV["SUBSCRIPTION_KEY"]})
      case response.code.to_i
      when 200
        return JSON.parse(response.body)
      else
        puts %(#{response.code}, #{response.message})
        return {}
      end
    end
  end
end
