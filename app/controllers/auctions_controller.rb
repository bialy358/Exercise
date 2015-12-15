class AuctionsController < ApplicationController
  skip_before_action :authenticate_user!, only:  [:index, :show]
  def index
    @auctions = Auction.all
  end

  def show
    @auction = Auction.find_by(id: params[:id])
  end

  def new
    @auction = current_user.auctions.new
  end

  def create
    @auction = current_user.auctions.new(auction_params)
    if @auction.save
      redirect_to auctions_path
    else
      render :new
    end
  end

  private

  def auction_params
    params.require(:auction).permit(:title, :description, :duration, :bid)
  end
end
