class StoreController < ApplicationController

  def index
    @products = Product.order(:title)
    @cart = current_cart
  end

  def search
    @products = Product.search(params[:q])

    respond_to do|format|
      format.html { redirect_to store_url }
      format.js { @products }
      format.json { render json: @product, status: :ok }
    end
  end
end
