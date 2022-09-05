class AuctionsController < ApplicationController
  before_action :authenticate_user!, except: ['show', 'open_auctions']
  before_action :get_shoe, only: ['show', 'new', 'edit', 'create', 'update', 'destroy']
  before_action :restrict_access, except: ['index','show', 'open_auctions']

  def index
    @auctions = current_user.auctions.all

    @auctions.each {|auction| update_auction_status(auction)}
  end

  def open_auctions
    @auctions = Auction.where(status: "Open").order("start_date ASC")
    
    @auctions.each {|auction| update_auction_status(auction)}
  end

  def show
    @auction = @shoe.auctions.find(params[:id])
    update_auction_status(@auction)
  end

  def new
    @auction = @shoe.auctions.build
  end

  def create
    @auction = @shoe.auctions.build(auction_params)

    if @auction.save
      update_auction_status(@auction)
      redirect_to shoe_auction_path(@shoe.id, @auction.id)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @auction = @shoe.auctions.find(params[:id])
  end

  def update
    @auction = @shoe.auctions.find(params[:id])

    if @auction.update(auction_params)
      redirect_to shoe_auction_path(@shoe.id, @auction.id)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @auction = @shoe.auctions.find(params[:id])
    @auction.destroy
    redirect_to shoes_path, status: 303
  end
    
  private
  def get_shoe
    @shoe = Shoe.find(params[:shoe_id])
  end

  def auction_params
    params.require(:auction).permit(:description, :start_date, :end_date, :payment_method, :starting_price)
  end

  def update_auction_status (auction)
    d = Time.zone.now
    if auction.start_date <= d && auction.end_date > d
      auction.update(status: "Open")
    elsif auction.end_date < d
      if auction.bids.count == 0
        auction.update(status: "Expired")
      else
        auction.update(status: "Sold")
      end
    end
  end

  def restrict_access
    if current_user.id != @shoe.user_id
      redirect_to shoe_path(@shoe.id)
    end
  end
end