class Bid < ActiveRecord::Base

  belongs_to :auction
  has_many :users

  validates :user_id, presence: true
  validates :auction_id, presence: true
  validate :date?, on: :update

private
  def date?
    if auction.finish_date <= DateTime.now
      errors.add(:value, "This auction has finished u can't bid up anymore")
    end
  end
end

