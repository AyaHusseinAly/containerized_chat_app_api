require 'redis'

class ChatsController < ApplicationController
  before_action :get_app , except: [:create]
  before_action :validate_app_existance , only: [:create]

  def index
    # status equals 200 when before_action method checks that token exists
    if @status == 200
      @response = @app.chats.select(:number, :message_count, :created_at, :updated_at).to_json(except: :id)
    end
    render json: @response, status: @status
  end

  def create
    if @status == 200
      @chat_number = REDIS.get(@token).to_i + 1
      REDIS.set(@token+'__'+@chat_number.to_s, 0)
      StoreChatsJob.perform_later(@chat_number, @token)
      @response = {chat_number: @chat_number}
    end
    render json: @response, status: @status
  end

  def show
    @chat_number = params[:number]
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
    @token = params[:application_token]
    @app = Application.find_by(token: @token)
    @status = 200
    if @app == nil
      @response = {errors: "app with token #{@token} is not found"}
      @status = 404
    end
  end

  private 
  def validate_app_existance
    @status = 200
    @token = params[:application_token]
    if REDIS.get(@token) == nil 
      @response = {errors: "app with token #{@token} is not found"}
      @status = 404
    end
  end

end
