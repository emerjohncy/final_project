class Auction < ApplicationRecord
    has_many :bids, dependent: :destroy
    belongs_to :shoe

    delegate :user, to: :shoe
end
