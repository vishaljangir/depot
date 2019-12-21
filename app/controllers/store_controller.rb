class StoreController < ApplicationController
  skip_before_action :authorize

  include CurrentCart
  before_action :set_cart_session
	before_action :track_index, only: [:index]
  
  def index
    # debugger  
    if params[:set_locale]
      # debugger
      redirect_to store_index_url(locale: params[:set_lcoale])
    else
      # debugger
      @products = Product.order(:title)
    end
  end

  private

  def track_index
  	if session[:counter].nil?
  		session[:counter] = 1
  	else
  		@count = session[:counter] += 1
      @count > 5 ? @count : @count = false
  	end 
  end
end
