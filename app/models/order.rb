class Order < ApplicationRecord
  has_many :product_lists
  belongs_to :user
end
