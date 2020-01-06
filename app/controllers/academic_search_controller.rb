# frozen_string_literal: true

class AcademicSearchController < ApplicationController
  include AcademicSearch
  before_action :set_request, only: [:search]

  def index
  end

  # Search by Academic Search API
  # @return [String] json formated responses
  def search
    if @is_top_referenced
      render json: AcademicSearchController.search_top_references(@request, @nums)
    else
      render json: AcademicSearchController.search_api(@request, @nums)
    end
  end

  private
    # Extend express parameter to @request
    def set_request
      @request = params[:expr]
      @nums = params[:nums].to_i
      @is_top_referenced = ActiveRecord::Type::Boolean.new.cast(params[:is_top_referenced])
    end
end
