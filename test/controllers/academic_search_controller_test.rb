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
      get academic_search_index_url, params: {is_top_referenced: "false"}
      assert_response :success
      assert_equal JSON.parse(@response.body, symbolize_names: true), {res: "OK"}
    end
  end

  test "return top referenced response case true" do
    AcademicSearchController.stub(:search_top_references, {res: "OK"}) do
      get academic_search_index_url, params: {is_top_referenced: "true"}
      assert_response :success
      assert_equal JSON.parse(@response.body, symbolize_names: true), {res: "OK"}
    end
  end

  test "use expr params" do
    get academic_search_index_url, params: {expr: "Composite(C.CN=='cvpr')", nums: 1, is_top_referenced: "false"}
    assert_response :success
    response = JSON.parse(@response.body)
    assert response.include?("entities")
    assert response["entities"][0].include?("Id")
    assert response["entities"][0].include?("Ti")
    assert response["entities"][0].include?("Y")
    assert response["entities"][0].include?("CC")
    assert response["entities"][0].include?("DN")
  end

  test "number of return" do
    get academic_search_index_url, params: {expr: "Composite(C.CN=='acl')", nums: 1, is_top_referenced: "false"}
    assert_response :success
    response = JSON.parse(@response.body)
    assert response.include?("entities")
    assert_equal 1, response["entities"].length
  end
end
