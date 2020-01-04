# frozen_string_literal: true

module AcademicSearch
  extend ActiveSupport::Concern

  class_methods do
    # Search by Academic Search API
    # @return [String] json formated responses
    def search_api(expr)
      return {}
    end
  end
end
