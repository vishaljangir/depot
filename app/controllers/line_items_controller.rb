class LineItemsController < ApplicationController
  skip_before_action :authorize, only: [:create, :decrease]

  include CurrentCart
  before_action :set_cart_session , only: :create 
  before_action :set_line_item, only: [:show, :decrease]


  def create
    product = Product.find(params[:product_id])
    @line_item = @cart.add_product(product)

    respond_to do |format|
      if @line_item.save
        session[:counter] = 0
        format.html { redirect_to store_index_url, notice: "Product Saved in Card" }
        format.js { @current_item = @line_item }
      else
        format.html { render :new }
      end
    end
  end

  def decrease  
    quantity = @line_item.quantity - 1
    if quantity == 0
      @line_item.destroy
      respond_to do |format|
        format.html { redirect_back(fallback_location: cart_path) }
      end
    else
      respond_to do |format|
        if @line_item.update_attribute(:quantity, quantity)
          format.html { redirect_to store_index_url }
        end
      end
    end
  end


  #     format.html { redirect_back(fallback_location: cart_path) }
  #   end
  # end

  private

    def set_line_item
      @line_item = LineItem.find(params[:id])
    end


    def line_item_params
      params.require(:line_item).permit(:product_id, :product_price)
    end

end
