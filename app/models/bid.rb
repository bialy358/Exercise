class Bid < ActiveRecord::Base
  belongs_to :auction
  has_many :users

  validates :user_id, presence: true
  validates :auction_id, presence: true
end
