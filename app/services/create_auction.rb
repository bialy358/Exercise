class CreateAuction
                                        ##########################################3
attr_reader :param_bid
## sprawdz interactor

def initialize(param_bid, auction)
  @param_bid = param_bid
  @auction = auction
end

def self.call(param_bid, auction)
  new(param_bid, auction).call
end

def call
  create_bid
  validate_receiver
  self
end

def success?

  return false if @auction.errors.present?
  @auction.bid_id= @bid
  @auction.save
end

private
def create_bid
  @bid = Bid.create(value: param_bid, user_id: current_user.id)
end

def validate_receiver
  @auction.errors.add(:bid, 'nie podano wartości') unless @bid
end

end