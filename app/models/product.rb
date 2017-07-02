class Product < ApplicationRecord
  mount_uploader :image, ImageUploader
  validates_presence_of :title
end
