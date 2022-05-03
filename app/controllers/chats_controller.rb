class ChatsController < ApplicationController
  def index
    render json: Chat.select(:number, :message_count, :created_at, :updated_at).to_json(except: :id)
  end

  def create
    @token = params[:application_id]
    @app = Application.find_by(token: @token)
    @status = 200
    if @app == nil
      @response = {errors: "app with token #{@token} is not found"}
      @status = 404
    else
      @chat = @app.chats.create(message_count: 0)
      @response = {chat_number: @chat.number}
    end
    render json: @response, status: @status
  end

  def show
    @token = params[:application_id]
    @chat_number = params[:id]
    @app = Application.find_by(token: @token)
    @status = 200
    if @app == nil
      @response = {errors: "app with token #{@token} is not found"}
      @status = 404
    else
      @chat = @app.chats.select(:number, :message_count, :created_at, :updated_at).find_by(number: @chat_number)
      if @chat == nil 
        @response = {errors: "chat with number #{@chat_number} is not found"}
        @status = 404
      else
        @response = {chat: @chat}
      end
      
    end
    render json: @response, status: @status
  end
end
