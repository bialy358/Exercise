class Auction < ActiveRecord::Base
  belongs_to :user
  has_one :bid

  accepts_nested_attributes_for :bid
  mount_uploader :picture, PictureUploader

  validates :starting_price, presence: true
  validates :user_id, presence: true
  validates :title, presence: true, length: {maximum: 50}
  validates :description, presence: true
  validates :duration, presence: true
  validate :image_size
  validate :duration?

  def finish_date
    date=self.created_at + self.duration.days
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

  private

    def image_size
      if picture.size > 512.kilobytes
        errors.add(:picture, "should be less than 512 kB")
      end
    end

    def duration?
      if duration.nil?
        errors.add(:duration, "should be between 1 - 14")
      elsif duration < 1 || duration > 14
        errors.add(:duration, "should be between 1 - 14")
        end
    end

end
