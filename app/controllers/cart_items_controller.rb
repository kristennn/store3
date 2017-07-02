class CartItemsController < ApplicationController

  def destroy
    @cart = current_cart
    @cart_item = @cart.cart_items.find_by(params[:product_id])
    @product = @cart_item.product
    @cart_item.destroy
    redirect_to carts_path, alert: "已将#{@product.title}删除"
  end

end
