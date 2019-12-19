require 'test_helper'

class LineItemsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @line_item = line_items(:first)
  end


  test "should create line_item" do

    assert_difference('LineItem.count') do
      post line_items_url, params: { product_id: @line_item.product_id }
    end
    assert_redirected_to store_index_url

    # assert_select '.heading', 'Your Pragmtic Catalog'
    # # debugger  
    # assert_select '.carts td', "MyString1"
  end


  test "should create line_item via ajax" do
    assert_difference('LineItem.count') do
      post line_items_url, params: { product_id: products(:two).id }, xhr: true
    end
    assert_response :success
    # debugger
    # assert_match /<tr class=\\"line_item-highlight/, @response.body
  end
end
