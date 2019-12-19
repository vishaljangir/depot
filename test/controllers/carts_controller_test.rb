require 'test_helper'

class CartsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @cart = carts(:one)
  end

  test "should create cart" do
    assert_difference('Cart.count') do
      post carts_url, params: { cart: {  } }
    end

    assert_redirected_to cart_url(Cart.last)
  end


  test "should destroy cart" do
 
    post line_items_url, params: { product_id: products(:one).id}
    
    cart = Cart.find(session[:cart_id])

    assert_difference('Cart.count', -1) do
      delete cart_url(cart)
    end

    assert_redirected_to store_index_url
  end

  test "both unique and duplicate product" do
    post line_items_url, params: { product_id: products(:two).id, product_price: products(:two).price }

    assert_redirected_to store_index_url
    # debugger
    # assert_select '.title', products(:one).title
  end
end
