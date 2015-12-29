class BidsController < ApplicationController

  def create
    binding.pry
    @bid = Bid.new(bids_params, user_id: current_user)
    if @bid.save
      redirect_to auctions_path
    else

    end
  end

  private

  def bids_params
    params.require(:bid).permit(:value)
  end
end