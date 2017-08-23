class Product < ApplicationRecord
  mount_uploader :image, ImageUploader
  validates_presence_of :title
  has_many :reviews

  has_many :favorites
  has_many :users, through: :favorites, source: :user

  def is_favorited?(user)
    self.users.include?(user)
  end

  def join_favorite!(user)
    self.users << user
    self.save
  end

  def quit_favorite!(user)
    self.users.delete(user)
    self.save
  end
end
