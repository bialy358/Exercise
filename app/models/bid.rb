class Bid < ActiveRecord::Base

  belongs_to :auction
  has_many :users

  validates :user_id, presence: true
  validates :auction_id, presence: true
  validate :date?, on: :create
  validate :value?, on: :create


private

  def date?
    if auction.finish_date <= DateTime.now
      errors.add(:value, "This auction has finished u can't bid up anymore")
    end
  end

  def value?
    if value < 0
      errors.add(:value, "Incorect value")
    end

    if !Bid.find_by(auction_id: auction.id).nil?
        if value <= Bid.where(auction_id: auction.id).last.value
          errors.add(:value, "You must bid up last price")
        end
    end

  end
end

