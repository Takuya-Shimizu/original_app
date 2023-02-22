class Postlabel < ApplicationRecord
  belongs_to :post
  belongs_to :label
end
