# frozen_string_literal: true

class AcademicSearchController < ApiController
  include AcademicSearch
  before_action :set_request

  # Search by Academic Search API
  # @return [String] json formated responses
  def index
    render json: AcademicSearchController.search_api(@request)
  end

  private
    # Extend express parameter to @request
    def set_request
      @request = params[:expr]
    end
end
