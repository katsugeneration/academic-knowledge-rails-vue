# frozen_string_literal: true

require "json"
require "test_helper"
require "minitest/autorun"

class AcademicSearchControllerTest < ActionDispatch::IntegrationTest
  test "return top from index" do
    get root_url
    assert_response :success
    assert_select "h1", "Academic Search"
  end

  test "return api response" do
    AcademicSearchController.stub(:search_api, {res: "OK"}) do
      get academic_search_index_url
      assert_response :success
      assert_equal JSON.parse(@response.body, symbolize_names: true), {res: "OK"}
    end
  end

  test "use expr params" do
    get academic_search_index_url, params: {expr: "Composite(C.CN=='acl')"}
    assert_response :success
    response = JSON.parse(@response.body)
    assert response.include?("entities")
    assert response["entities"][0].include?("Id")
  end
end
