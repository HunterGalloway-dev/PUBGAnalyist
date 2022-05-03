require "test_helper"

class AdminsControllerTest < ActionDispatch::IntegrationTest
  test "should get populate_database" do
    get admins_populate_database_url
    assert_response :success
  end
end
