class Order < ApplicationRecord
  has_many :product_lists
  belongs_to :user

  def pay!
    self.update_columns(is_paid: :true)
  end

  def set_payment_method!(method)
    self.update_columns(payment_method: method)
  end

  include AASM

  aasm do
    state :order_placed, initial: true
    state :paid
    state :shipping
    state :shipped
    state :good_returned
    state :order_canceled

    event :make_payment, after_commit: :pay! do
      transitions from: :order_placed, to: :paid
    end

    event :ship do
      transitions from: :paid, to: :shipping
    end

    event :deliver do
      transitions from: :shipping, to: :shipped
    end

    event :return_good do
      transitions from: :shipped, to: :good_returned
    end

    event :cancel_order do
      transitions from: [:order_placed, :paid], to: :order_canceled
    end

  end

end
