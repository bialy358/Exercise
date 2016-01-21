class MessagesController < ApplicationController
  def index
    @messages = Message.messages_for(current_user)
  end
  def new
    @message = current_user.messages.new
  end
  def show
    @message = Message.find_by(id: params[:id])
  end
  def create

  #form_object albo interactor
    @message = current_user.messages.new(message_params)

    context = CreateMessage.call(params[:message][:receiver], @message)
    if context.success?
      send_email(Message.last)
      redirect_to messages_path
    else
      render :new
    end
  end

  private

  def message_params
    params.require(:message).permit(:title, :content)
  end

  def send_email(message)
    Mail.defaults do
           delivery_method :smtp, {
                                    :user_name => '54984d4bc50e6cd24',
                                    :password => 'e3f13a7f4a09a1',
                                    :address => 'mailtrap.io',
                                    :domain => 'mailtrap.io',
                                    :port => '2525',
                                    :authentication => :cram_md5
                                }
           end

    Mail.deliver do
      from     'messenger@auction-house.com'
      to       User.find_by(id: message.receiver_id).email
      subject  "You have a new message at auction-house.com"
      body     "From: " + User.find_by(id: message.user_id).email + "\n Content:" + "\n" + message.content + "\n"
      end
end


end