class Shoe < ApplicationRecord
    belongs_to :user
    has_many :auctions, dependent: :destroy
    has_one_attached :image

    validates :brand, presence: true
    validates :model, presence: true
    validates :size, presence: true
    validates :image, presence: true

    validates_associated :auctions
end
