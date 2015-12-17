class AuctionsController < ApplicationController
  skip_before_action :authenticate_user!, only:  [:index, :show]
  def index
    @auctions = Auction.all
    @bid = Bid.find_by(id: params[:bid_id])
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
      Bid.create(value: @auction.starting_price, user_id: @auction.user_id, auction_id: @auction.id)
      redirect_to auctions_path
    else
      render :new
    end
  end

  private

  def auction_params
    params.require(:auction).permit(:title, :description, :duration, :picture, :starting_price)
  end

end
