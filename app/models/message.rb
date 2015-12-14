class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :ziom, class_name: 'User', foreign_key: 'receiver_id'

  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  validates :title, presence: true, length: {minimum: 4, maximum: 50}

  scope :messages_for, ->(current_user) {where('user_id = ? OR receiver_id = ?', current_user.id, current_user.id)}

end
