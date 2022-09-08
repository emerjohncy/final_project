class Admins::DashboardController < Devise::SessionsController
  before_action :authenticate_admin!
  
  def index
    @users = User.all
    @shoes = Shoe.all
    @auctions = Auction.all
  end

end