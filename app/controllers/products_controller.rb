class ProductsController < ApplicationController
  before_action :authenticate_user!, except:[:index, :show, :add_to_cart]
  before_action :validate_search_key, only: [:search]

  def index
    @products = Product.all
    case params[:category]
    when "餐"
      @products = Product.all.where(:category => "餐")
    when "茶"
      @products = Product.all.where(:category => "茶")
    when "酒"
      @products = Product.all.where(:category => "酒")
    when "香"
      @products = Product.all.where(:category => "香")
    when "花"
      @products = Product.all.where(:category => "花")
    end
  end

  def show
    @review = Review.new
  end

  def add_to_cart
    @product = Product.find(params[:id])
    if !current_cart.products.include?(@product)
      current_cart.add_product_to_cart(@product)
      flash[:notice] = "成功将#{@product.title}加入购物车"
    else
      flash[:warning] = "此商品已在购物车"
    end
    redirect_to product_path(@product)
  end

  def search
    if @query_string.present?
      @products = search_params
    end
  end

  def join_favorite
    @product = Product.find(params[:id])
    if !@product.is_favorited?
      @product.join_favorite!(current_user)
    else
      flash[:warning] = "您已加入收藏"
    end
  end

  def quit_favorite
    @product = Product.find(params[:id])
    if @product.is_favorited?
      @product.quit_favorite!(current_user)
    else
      flash[:warning] = "您没有加入收藏，怎么删除？"
    end
  end

  protected

  def validate_search_key
    @query_string = params[:q].gsub(/\\|\'|\/|\?/, "") if params[:q].present?
  end

  def search_params
    Product.ransack({:title_or_description_cont => @query_string}).result(distinct: true)
  end

end
