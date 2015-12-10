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
    @message.errors.add(:receiver, 'bledny format') unless param_receiver.match(VALID_EMAIL_REGEX)
    @message.errors.add(:receiver, 'nie ma huja') unless @receiver
  end

end

