class MessagesController < ApplicationController
  def index
    @messages = Message.where('user_id = ? OR receiver_id = ?', current_user.id, current_user.id)
  end
  def new
    @message = current_user.messages.new
  end

  def create

    @message = current_user.messages.new(message_params)
    if @message.save
      redirect_to messages_path
    else

      render :new
    end
  end

  private

  def message_params
    params.require(:message).permit(:title, :content, :receiver)
  end
end

