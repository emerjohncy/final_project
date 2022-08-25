class Auction < ApplicationRecord
    has_many :bids
    belongs_to :shoe

    delegate :user, to: :shoe
end
