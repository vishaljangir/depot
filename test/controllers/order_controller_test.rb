require 'test_helper'

class OrderControllerTest < ActionDispatch::IntegrationTest

	def setup
		@order = orders(:one)
	end

  test "should get new" do
  	post line_items_url, params: { product_id: products(:two).id }
    
    assert_redirected_to store_index_path
  end

  test "should create order" do
  	assert_difference('Order.count') do
  		post orders_path, params: { order: { name: 		@order.name,
  																				address: 	@order.address,
  																				email: 		@order.email,
  																				pay_type: @order.pay_type }}
  	end

  	assert_redirected_to store_index_path
  end

end
