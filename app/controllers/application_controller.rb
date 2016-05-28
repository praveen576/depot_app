class ApplicationController < ActionController::Base
  
  protect_from_forgery

  before_filter :authenticate_user!

  private
  def current_cart
    cart = current_user.cart
    unless cart
      cart = current_user.create_cart
    end
    cart
  end
end
