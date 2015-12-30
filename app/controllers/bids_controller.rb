class BidsController < ApplicationController

  def create
    @auction = find_auction
    @bid = @auction.bids.new(bids_params)
    @bid.user_id = current_user.id
    if @bid.save
      redirect_to @auction
    else
      redirect_to @auction
    end
  end

  private

  def find_auction
    Auction.find(params[:auction_id])
  end

  def bids_params
    params.require(:bid).permit(:value)
  end
end