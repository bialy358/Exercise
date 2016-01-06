class Bid < ActiveRecord::Base

  belongs_to :auction
  has_many :users

  validates :user_id, presence: true
  validates :auction_id, presence: true
  validate :date?, on: :create
  validate :value?, on: :create
  validate :user?, on: :create

private

  def date?
    if auction.finish_date <= DateTime.now
      errors.add(:date, "This auction has finished u can't bid up anymore.")
    end
  end

  def value?
    if value.nil? || value < 0
      errors.add(:value, "incorrect.")
    else
      ## checking only when there is already starting bid
      unless Bid.find_by(auction_id: auction.id).nil?
        if value <= Bid.where(auction_id: auction.id).last.value
          errors.add(:value, "is smaller than the previous one.")
        end
      end
    end
  end

  def user?
    ## checking only when there is already starting bid
    unless Bid.find_by(auction_id: auction.id).nil?
      if user_id == auction.user_id
        errors.add(:user, "you can't bid up your own auction.")
      else
        if user_id == Bid.where(auction_id: auction.id).last.user_id
          errors.add(:user, "you already made the highest bid.")
        end
      end
    end
    end
end

