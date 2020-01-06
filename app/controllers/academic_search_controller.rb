# frozen_string_literal: true

class AcademicSearchController < ApplicationController
  include AcademicSearch
  before_action :set_request, only: [:search]

  def index
  end

  # Search by Academic Search API
  # @return [String] json formated responses
  def search
    render json: AcademicSearchController.search_api(@request, @nums)
  end

  private
    # Extend express parameter to @request
    def set_request
      @request = params[:expr]
      @nums = params[:nums]
    end
end
