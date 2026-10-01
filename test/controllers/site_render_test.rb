require "test_helper"

class SiteRenderTest < ActionDispatch::IntegrationTest
  test "home, posts and articles render with importmap assets" do
    get root_path
    assert_response :success
    assert_select "script[type=module]"

    get posts_path
    assert_response :success

    get articles_path
    assert_response :success
  end
end
