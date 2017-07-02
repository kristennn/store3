class OrdersController < ApplicationController

  def create
    @order = Order.new(order_params)
    @order.user = current_user
    @order.total = current_cart.total_price

    if @order.save

      current_cart.cart_items.each do |cart_item|
        product_list = ProductList.new
        product_list.order = @order
        product_list.product_name = cart_item.product.title
        product_list.product_price = cart_item.product.price
        product_list.quantity = cart_item.quantity
        product_list.save
      end
      current_cart.clean!
      redirect_to order_path(@order)
    else
      render "carts/checkout"
    end
  end

  def show
    @order = Order.find(params[:id])
    @product_lists = @order.product_lists
  end

  def pay_with_alipay
    @order = Order.find(params[:id])
    @order.set_payment_method!("alipay")
    @order.make_payment!
    redirect_to order_path(@order)
    flash[:notice] = "使用支付宝支付成功"
  end

  def pay_with_wechat
    @order = Order.find(params[:id])
    @order.set_payment_method!("wechat")
    @order.make_payment!
    redirect_to order_path(@order)
    flash[:notice] = "使用微信支付成功"
  end

  private

  def order_params
    params.require(:order).permit(:billing_name, :billing_address, :shipping_name, :shipping_address)
  end

end
