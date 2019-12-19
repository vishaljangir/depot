require 'test_helper'

class OrderMailerTest < ActionMailer::TestCase
  test "received" do
    mail = OrderMailer.received(orders(:one))
    assert_equal "Toy Store Order Confirmation", mail.subject
    assert_equal ["dave@gmail.com"], mail.to
    assert_equal ["vishaljangir022@gmail.com"], mail.from
    # assert_match "1/ * Seven/", mail.body.encoded
  end

  test "shipped" do
    mail = OrderMailer.shipped(orders(:one))
    assert_equal "Toy Store Order Shipped", mail.subject
    assert_equal ["dave@gmail.com"], mail.to
    assert_equal ["vishaljangir022@gmail.com"], mail.from
    # assert_match "Hi", mail.body.encoded
  end

end
