class BidsController < ApplicationController

  def create
    @auction = find_auction
    @new_bid = @auction.bids.new(bids_params)
    @new_bid.user_id = current_user.id
    if @new_bid.save
      redirect_to @auction
    else
      @bids = Bid.where(auction_id: @auction.id)
      render 'auctions/show'
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