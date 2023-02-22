class Label < ApplicationRecord
  has_many :postlabels, dependent: :destroy
  has_many :posts, through: :postlabels
end