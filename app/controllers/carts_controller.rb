class CartsController < ApplicationController
  before_filter :authenticate_user!
  
  def show
    @cart = current_cart
  end
end