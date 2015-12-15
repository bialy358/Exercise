class Auction < ActiveRecord::Base
  belongs_to :user

  validates :user_id, presence: true
  validates :title, presence: true, length: {maximum: 100}
  validates :description, presence: true
  validates :duration, presence: true

  def finish_date
    date=self.created_at + self.duration.days
    date.strftime('%F %T')
  end
end
