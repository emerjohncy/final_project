class BidController < ApplicationController
  def create
  end

  def show
  end

  private
  def get_shoe
    @shoe = Shoe.find(params[:id])
  end
end
