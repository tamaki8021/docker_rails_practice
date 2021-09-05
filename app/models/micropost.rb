class Micropost < ApplicationRecord
  validates :contentt, length: { maximum: 140 }
end
