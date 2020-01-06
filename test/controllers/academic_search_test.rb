# frozen_string_literal: true

require "test_helper"

class TestModule
  include AcademicSearch
end

class AcademicSearchTest < ActiveSupport::TestCase
  test "search response" do
    response = TestModule.search_api("Composite(C.CN=='acl')")
    assert response.include?("entities")
    assert response["entities"][0].include?("Id")
  end

  test "search invalid expr" do
    response = TestModule.search_api("Cmposite(C.CN=='acl')")
    assert_not response.include?("entities")
  end
end
