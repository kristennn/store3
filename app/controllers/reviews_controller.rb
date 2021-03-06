class ReviewsController < ApplicationController

  def create
    @product = Product.find(params[:product_id])
    @review = Review.new(review_params)
    @review.product = @product
    @review.user = current_user
    @review.save
    redirect_to product_path(@product)

  end

  private

  def review_params
    params.require(:review).permit(:content)
  end

end
