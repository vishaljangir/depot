require 'test_helper'

class ProductTest < ActiveSupport::TestCase

	def setup
		@product = Product.new(title: "seven wonders", 
													 description: "New7Wonders of the World (2000–2007) was a 
													 							 campaign started in 2000 to choose Wonders.",
													 image_url: "animation.jpg",
													 price: "50.0")
		@first_product = products(:one)
	end

	test "product should be valid" do
		assert @product.valid?
	end

	test "product attributes must not be empty" do
		product = Product.new
		assert product.invalid?
		assert product.errors[:title].any?
		assert product.errors[:description].any?
		assert product.errors[:image_url].any?
		assert product.errors[:price].any?
	end

	test "product price must be positive" do
		assert @product.valid?
		@product.price = -1
		assert @product.invalid?
		assert_equal ["must be greater than or equal to 0.01"], @product.errors[:price]

		@product.price = 0
		assert @product.invalid?
		assert_equal ["must be greater than or equal to 0.01"], @product.errors[:price]

		@product.price = 1
		assert @product.valid?

	end

	def new_product(image_url: "animation.jpg", title: "seven wonders")
		Product.new(title: title, 
							 description: "New7Wonders of the World (2000–2007) was a 
							 							 campaign started in 2000 to choose Wonders.",
							 image_url: image_url,
							 price: "50.0")
	end

	test "product image_url" do
		ok = %w{ fred.gif fred.jpg fred.png }

		ok.each do |image_url|
			assert new_product(image_url: image_url).valid?, "#{image_url} should't be invalid"
		end
		bad = %w{ fred.doc fred.gif/more fred.png.more }

		bad.each do |image_url|
			assert new_product(image_url: image_url).invalid?, "#{image_url} should't be invalid"
		end
	end

	test "product title should be unique" do
		# debugger
		pre = new_product(title: @first_product.title)
		assert_not pre.valid?
		assert_equal [I18n.translate('errors.messages.taken')], pre.errors[:title]
	end
end
