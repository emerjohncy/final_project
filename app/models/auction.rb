class Auction < ApplicationRecord
    has_many :bids, dependent: :destroy
    belongs_to :shoe

    delegate :user, to: :shoe

    validates :description, presence: true
    validates :starting_price, presence: true
    validates :start_date, comparison: { greater_than_or_equal_to: Time.zone.now }
    validates :end_date, comparison: { greater_than: :start_date }

    validates_associated :bids
end
