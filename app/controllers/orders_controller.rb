class OrdersController < ApplicationController
  skip_before_action :authorize, only: [:new, :create]

	include CurrentCart
  before_action :set_cart_session, only: [:new, :create]
  before_action :ensure_cart_isnt_empty, only: :new

  def index
  	@orders = Order.order(:created_at)
  end

  def new
  	@order = Order.new
  end

  def create
  	@order = Order.new(order_params)
  	@order.add_line_items_from_cart(@cart)
  	respond_to do |format|
	  	if @order.save
	  		Cart.destroy(session[:cart_id])
	  		session[:cart_id] = nil
        ChargeOrderJob.perform_later(@order,pay_type_params.to_h)
	  		format.html { redirect_to store_index_url(locale: I18n.locale), notice: I18n.t('.thanks') }
	  	else
        format.html { render :new }
	  	end
  	end
  end

  private

  	def order_params
  		params.require(:order).permit(:name, :address, :email, :pay_type)
  	end

    def pay_type_params
      if order_params[:pay_type] == "Credit card"
        params.require(:order).permit(:credit_card_number, :expiration_date)
      elsif order_params[:pay_type] == "Check"
        params.require(:order).permit(:routing_number, :account_number)
      elsif order_params[:pay_type] == "Purchase order"
          params.require(:order).permit(:po_number)
      else
        {}
      end
    end

	  def ensure_cart_isnt_empty
	  	if @cart.line_items.empty?
	 			redirect_to store_index_url, notice: 'Your cart is empty'
	  	end
	  end
end
