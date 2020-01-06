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
      attributes = ["Id", "Ti", "RId", "CC", "C.CN", "J.JN", "Y", "DN"]
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

    # Search top k references papers from expr matched papers
    #
    # @param expr [String] Expression string whoes cited papers.
    # @param count [Int] Number of returning papres.
    #
    # @return [Hash] json parsed objects.
    def search_top_references(expr, count = 10)
      papers = search_api(expr, 1000)

      sorted_referenced_papers = papers["entities"].inject([]) { |result, arr|
        if arr["RId"].instance_of?(Array)
          result + arr["RId"]
        else
          result
        end
      }.group_by(&:itself)
      .map { |key, value| [key, value.count] }
      .sort { |(k1, v1), (k2, v2)| v2 <=> v1 }

      request = "Or(#{sorted_referenced_papers[0, count].map { |key, value|
        "Id=#{key}"
      }.join(",")})"

      return search_api(request, count)
    end
  end
end
