class Product < ApplicationRecord
  mount_uploader :image, ImageUploader
  validates_presence_of :title
  has_many :reviews
end
