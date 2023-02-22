class Post < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :user
  has_many :comments, dependent: :destroy
  has_many :postlabels, dependent: :destroy
  has_many :labels, through: :postlabels
  scope :tagged_with, ->(label) { joins(:labels).where(labels: { name: label }) if label.present? }
end
