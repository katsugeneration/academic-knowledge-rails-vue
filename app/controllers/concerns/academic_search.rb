# frozen_string_literal: true

require "uri"
require "net/http"
require "json"

module AcademicSearch
  extend ActiveSupport::Concern

  class_methods do
    # Search by Academic Search API
    #
    # @param expr [String] Academic Search API expression string.
    # @param count [Int] Number of returning papres.
    #
    # @return [Hash] json parsed objects.
    #
    # @note This method use SUBSCRIPTION_KEY environment variable.
    def search_api(expr, count = 10)
      attributes = ["Id", "Ti", "RId", "CC", "C.CN", "J.JN", "Y"]
      uri = URI.parse("https://api.labs.cognitive.microsoft.com/academic/v1.0/evaluate?expr=#{expr}&attributes=#{attributes.join(',')}&count=#{count}")
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
