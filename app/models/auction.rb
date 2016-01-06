class Auction < ActiveRecord::Base
  belongs_to :user
  has_many :bids

  mount_uploader :picture, PictureUploader

  define_callbacks :create

  validates :starting_price, presence: true
  validates :user_id, presence: true
  validates :title, presence: true, length: {maximum: 50}
  validates :description, presence: true
  validates :duration, presence: true
  validate :image_size
  validate :duration?
  validate :starting_price?

  def create
    run_callbacks :create do

    end
  end

  after_create :create_starting_bid

  def finish_date
    date=created_at + duration.days
    date.strftime('%F %T')
  end

  def image
    if picture?
      picture.url
    else
      'logo.png'
    end
  end

  def thumb
    unless picture.thumb.url.nil?
      picture.thumb.url
    else
      'thumb_logo.png'
    end
  end

  scope :my_auctions, ->(current_user) {where('user_id = ?', current_user.id)}





  private

  def create_starting_bid
    Bid.create(value: starting_price, user_id: user_id, auction_id: id)
  end


    def image_size
      if picture.size > 512.kilobytes
        errors.add(:picture, "should be less than 512 kB")
      end
    end

    def duration?
      unless duration.nil?
        if duration < 1 || duration > 14
          errors.add(:duration, "should be between 1 - 14")
        end
      end
    end

    def starting_price?
      unless starting_price.nil?
        if starting_price < 0
          errors.add(:value, "of starting price should be positive")
        end
      end
    end

end
