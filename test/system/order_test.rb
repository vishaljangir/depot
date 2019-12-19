require "application_system_test_case"
include ActiveJob::TestHelper

class OrdersTest < ApplicationSystemTestCase
	test "check routing number" do
		LineItem.delete_all
		Order.delete_all

		visit store_index_url
		first('.catalog li').click_on 'Add to Cart'

		click_on 'Checkout', match: :first

		fill_in 'order_name', with: 'vishal jangir'
		fill_in 'order_address', with: '123 jaipur'
		fill_in 'order_email', with: 'vishal@gmail.com'

		assert_no_selector "#orderf_routing_number"

		select 'Check', from: 'pay_type'

		assert_selector "#order_routing_number"

		fill_in "Routing #", with: "123456"
		fill_in "Account #", with: "123456"

		# click_on "Place Order"
			perform_enqueued_jobs do
				click_button "Place Order"
			end

		orders = Order.all 
		assert_equal 1, orders.size

		order = orders.first

		assert_equal "vishal jangir", 			order.name
		assert_equal "123 jaipur", 						order.address
		assert_equal "vishal@gmail.com", 	order.email
		assert_equal "Check", 						order.pay_type
		assert_equal 1, order.line_items.size

# debugger
		mail = ActionMailer::Base.deliveries.last
		assert_equal ["dave@example.com"],								mail.to
		assert_equal 'vishaljangir022@gmail.com',					mail[:form].value
		assert_equal "Toy Store Order Confirmation",			mail.subject
	end
end