class Product < ApplicationRecord
	has_many :line_items
	has_many :orders, through: :line_items

	validates :title, :description, :image_url, presence: true
	validates :price, numericality: { greater_than_or_equal_to: 0.01 }
	validates :title, uniqueness: true, length: { maximum: 10, message: "length should be lessthan 10"}
	validates :image_url, allow_blank: true, format: {
		with: %r{\.(gif|jpg|png)\Z}i,
		message: 'Must be a URL for GIF, JPG, or PNG Image.'
	}

	before_destroy :ensure_not_reference_by_any_line_item
	private

	def ensure_not_reference_by_any_line_item
		unless line_items.empty?
			errors.add(:base, 'Line Item Present')
			throw :abort
		end
	end
end
