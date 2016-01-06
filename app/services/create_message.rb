class CreateMessage
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  attr_reader :param_receiver
 ## sprawdz interactor
  def initialize(param_receiver, message)
    @param_receiver = param_receiver
    @message = message
  end

  def self.call(param_receiver, message)
    new(param_receiver, message).call
  end

  def call
    set_receiver
    validate_receiver
    self
  end

  def success?

    return false if @message.errors.present?
    @message.ziom= @receiver
    @message.save
  end

  private
  def set_receiver
    @receiver = User.find_by(email: param_receiver)
  end

  def validate_receiver

    @message.errors.add(:receiver, 'Ensure that email is in xx@xx.xx format') unless param_receiver.match(VALID_EMAIL_REGEX)
    unless @receiver
      @message.errors.add(:receiver, 'There is not such user')
    else
      if @receiver.id == @message.user_id
        @message.errors.add(:receiver, "You can't send message to yourself")
      end
    end
  end

end

