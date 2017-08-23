class Product < ApplicationRecord
  mount_uploader :image, ImageUploader
  validates_presence_of :title
  has_many :reviews

  has_many :favorites
  has_many :users, through: :favorites, source: :user
end
