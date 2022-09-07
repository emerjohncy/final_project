class PagesController < ApplicationController
    before_action :authenticate_user!, only: [:profile, :buying_selling]

    def profile
        @user = current_user
        @bids = current_user.bids.limit(5).order('created_at DESC')
        @bids_all = current_user.bids.all
        @shoes = current_user.shoes.limit(3).order('created_at DESC')
        @shoes_all = current_user.shoes.all
    end

    def home
        @coming_soon = Auction.where("start_date > ?", Time.zone.now).order("start_date ASC").limit(6)

        auction_bids = Auction.select("auctions.id, COUNT(bids.id) bids_count").joins(:bids).where(status: "Open").group("auctions.id").order("bids_count DESC").limit(6)

        @trending = Auction.where(id: auction_bids.map(&:id))

        @user = current_user
    end

    def faq

    end

end
