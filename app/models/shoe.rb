class Shoe < ApplicationRecord
    belongs_to :user
    has_many :auctions
end
