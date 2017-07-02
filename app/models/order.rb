class Order < ApplicationRecord
  has_many :product_lists
  belongs_to :user

  def pay!
    self.update_columns(is_paid: :true)
  end

  def set_payment_method!(method)
    self.update_columns(payment_method: method)
  end

end
