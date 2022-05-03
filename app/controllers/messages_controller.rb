class MessagesController < ApplicationController
  def index
    render json: Message.all()
  end

  def create
    @chat = Chat.where(number: params[:chat_number]).first
    @msg = @chat.messages.create(body: params[:msg_body])
    render json: {msg_number: @msg.number}
  end

  def update
  end

  def show
  end

  def search
  end
end
