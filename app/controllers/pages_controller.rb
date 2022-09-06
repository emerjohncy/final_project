class PagesController < ApplicationController
    before_action :authenticate_user!, only: [:profile, :buying_selling]

    def profile
        @user = current_user
    end

    def home
        @coming_soon = Auction.where("start_date > ?", Time.zone.now).order("start_date ASC").limit(6)
      
        auction_bids = Auction.select("auctions.id, COUNT(bids.id) bids_count").joins(:bids).where(status: "Open").group("auctions.id").order("bids_count DESC").limit(6)

        @trending = Auction.where(id: auction_bids.map(&:id))
    end

    def faq
    
    end

    def buying_selling
        @user = current_user
    end
end