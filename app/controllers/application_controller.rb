class ApplicationController < ActionController::Base
  
  protect_from_forgery

  before_filter :authorize

  private
  def current_cart
    cart = Cart.find_by_id(session[:cart_id])
    unless cart
      cart = Cart.create
      session[:cart_id] = cart.id
    end
    cart
  end

  def authorize
    unless User.find_by_id(session[:user_id])
      redirect_to login_url, notice: 'Please login..!!'
    end
  end
end
