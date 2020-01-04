# frozen_string_literal: true

require "test_helper"

class AcademicSearchControllerTest < ActionDispatch::IntegrationTest
  test "search response" do
    get academic_search_index_url
    assert_response :success
  end
end
