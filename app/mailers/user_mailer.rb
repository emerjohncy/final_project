class UserMailer < ApplicationMailer
    # default from: 'notifications@example.com'

  def welcome_email
    @user = params[:user]
    mail(to: @user.email, subject: 'Welcome to AucShoes!')
  end

  def bid_success
    @bid = params[:bid]
    @owner = @bid.auction.user
    @bidder = @bid.user
    mail(to: @owner.email, subject: "AucShoes Bid Success")
  end
  
end
