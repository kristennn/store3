class CartsController < ApplicationController

  def clean
    @cart = current_cart
    @cart.clean!
    redirect_to carts_path, alert: "已清空购物车"
  end

end
