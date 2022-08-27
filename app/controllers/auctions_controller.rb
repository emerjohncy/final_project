class AuctionsController < ApplicationController
  before_action :authenticate_user!, except: ['show']
  before_action :get_shoe, only: ['show', 'new', 'edit', 'create', 'update', 'destroy']

  def index
    @auctions = current_user.auctions.all
  end

  def show
    @auction = @shoe.auctions.find(params[:id]) 

    # @auction.update(status: "Open")
  end

  def new
    @auction = @shoe.auctions.build
  end

  def create
    @auction = @shoe.auctions.build(auction_params)

    if @auction.save
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
end