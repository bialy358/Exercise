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
      redirect_to messages_path
    else
      render :new
    end
  end

  private

  def message_params
    params.require(:message).permit(:title, :content)
  end

end

