class BidsController < ApplicationController
  before_action :authenticate_user!
  before_action :get_auction, only: ['history_bids', 'new', 'create']
  before_action :get_shoe, only: ['new', 'create']
  before_action :get_user, only: ['index', 'history_bids', 'new', 'create']

  def index
    @bids = current_user.bids.all
  end

  def history_bids
    @bids = @auction.bids.all
  end

  def new
    @bid = @auction.bids.build
  end

  def create
    @bid = @auction.bids.build(bid_params)
    @bid.user_id = current_user.id
    if bid_params[:price].present?
      if (@auction.bids.count == 0 && @bid.price > @auction.starting_price) || (@auction.bids.count > 0 && @bid.price > @auction.bids.second_to_last.price)
        save_bid(@bid)
        flash[:success] = "You have bid successfully!"
      else
        flash[:error] = "You must bid higher!"
        redirect_to shoe_auction_path(@shoe.id, @auction.id)
      end
    else
      flash[:error] = "You must input a bid!"
      redirect_to shoe_auction_path(@shoe.id, @auction.id)
    end
  end

  private
  def get_auction
    @auction = Auction.find(params[:auction_id])
  end

  def get_shoe
    @shoe = Shoe.find(params[:shoe_id])
  end

  def bid_params
    params.require(:bid).permit(:price)
  end

  def save_bid(bid)
    if bid.save
      UserMailer.with(bid: bid).bid_success.deliver_later
      redirect_to shoe_auction_path(@auction.shoe_id, @auction.id)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def get_user
    @user = current_user
  end
end
