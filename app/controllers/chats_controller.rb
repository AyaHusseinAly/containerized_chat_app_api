class ChatsController < ApplicationController
  def index
    render json: Chat.all()
  end

  def create
    @app = Application.where(token:params[:application_token]).first
    @chat = @app.chats.create(message_count: 0)
    render json: {chat_number: @chat.number}
  end

  def update
  end

  def show
  end
end
