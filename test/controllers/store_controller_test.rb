require 'test_helper'

class StoreControllerTest < ActionDispatch::IntegrationTest


  test "should get index" do
    get store_index_url
    assert_response :success
    assert_select 'nav.side_nav a', minimum: 2
    # debugger
    assert_select 'main ul.catalog li', 3
    assert_select 'h1', 'Your Pragmtic Catalog'
    assert_select 'h2', 'Seven'
    assert_select '.price', /\$[,\d]+\.\d\d/
  end

end
