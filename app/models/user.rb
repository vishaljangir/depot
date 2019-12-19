class User < ApplicationRecord
  attr_accessor :current_password
  validate :check_auth, on: :update

	after_destroy :ensure_an_admin_remains
	validates :name, presence: true, uniqueness: true
  has_secure_password
  class Error < StandardError
  end

  
  private

  def check_auth
    user = User.find(id)
    if !user.authenticate(current_password)
      errors.add(:current_password, "didn't match")
    end
  end

  def ensure_an_admin_remains
  	if User.count.zero?
  		raise Error.new "Can't delete last user"
  	end
  end
end
