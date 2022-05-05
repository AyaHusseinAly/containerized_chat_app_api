require 'redis'

class ChatsController < ApplicationController
  before_action :get_app

  def index
    # @status == 200 after before_action method checks that token exists
    if @status == 200
      @response = @app.chats.select(:number, :message_count, :created_at, :updated_at).to_json(except: :id)
    end
    render json: @response, status: @status
  end

  # def create
  #   if @status == 200
  #     @chat = @app.chats.create(message_count: 0)
  #     @response = {chat_number: @chat.number}
  #   end
  #   render json: @response, status: @status
  # end

  def create
    if @status == 200
      # @chat = @app.chats.create(message_count: 0)
      @chat = Chat.new(message_count: 0) # assign app_id before save for time saving 
      generate_number()
      REDIS.lpush("chat_queue", [@chat])
      @response = {chat_number: @chat.number}
    end
    render json: @response, status: @status
  end

  def show
    @chat_number = params[:id]
    if @status == 200
      @chat = @app.chats.find_by(number: @chat_number)
      if @chat == nil 
        @response = {errors: "chat with number #{@chat_number} is not found"}
        @status = 404
      else
        @response = @chat.to_json(except: [:id,:application_id])
      end
      
    end
    render json: @response, status: @status
  end

  private
  def get_app
    @token = params[:application_id]
    @app = Application.find_by(token: @token)
    @status = 200
    if @app == nil
      @response = {errors: "app with token #{@token} is not found"}
      @status = 404
    end
  end

  private
  def generate_number
    # group().max() return hash >>  {app_id_1=> val1, app_id_2=>val2}
    app_chat_count = Chat.group(:application_id).maximum("number")[@chat.application_id]
    @chat.number =  app_chat_count == nil ? 1 : app_chat_count + 1
  end
end
