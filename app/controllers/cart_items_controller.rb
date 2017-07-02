class CartItemsController < ApplicationController

  def destroy
    @cart = current_cart
    @cart_item = @cart.cart_items.find_by(product_id: params[:id])
    @product = @cart_item.product
    @cart_item.destroy
    redirect_to carts_path, alert: "已将#{@product.title}删除"
  end

  def update
    @cart = current_cart
    @cart_item = @cart.cart_items.find_by(product_id: params[:id])
    if @cart_item.product.quantity >= cart_item_params[:quantity].to_i
    @cart_item.update(cart_item_params)
    redirect_to carts_path, notice: "更新数量成功"
  else
    flash[:warnint] = "商品数量不足以加入购物车"
  end
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:quantity)
  end

end
