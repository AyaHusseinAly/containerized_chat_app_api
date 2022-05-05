class MessagesController < ApplicationController
  before_action :get_chat

  def index
    # @status == 200 after get_chat method checks that token and chat_number exists
    if @status == 200
      @response = @chat.messages.select(:number, :body, :created_at, :updated_at).to_json(except: :id)
    end
    render json: @response, status: @status
  end
  
  def create
    if @status == 200
      @msg = @chat.messages.create(body: params[:msg_body])
      @response = @msg.errors.any? ? {errors: @msg.errors.full_messages} : {message_number: @msg.number}
    end
    render json: @response, status: @status
  end

  def update
    if @status == 200
      @msg = @chat.messages.find_by(number: @msg_number)
      if @msg == nil
        @response = {errors: "message with number #{@msg_number} is not found"}
        @status = 404
      else
        @msg.body = params[:msg_body]
        @msg.save()
        @response = @msg.to_json(except: [:id,:chat_id])
      end
    end
    render json: @response, status: @status
  end


  def show
    if @status == 200
      @msg = @chat.messages.find_by(number: @msg_number)
      if @msg == nil
        @response = {errors: "message with number #{@msg_number} is not found"}
        @status = 404
      else
        @response = @msg.to_json(except: [:id,:chat_id])
      end
    end
    render json: @response, status: @status
  end

  def search
    if @status == 200
      @response = Message.search(params[:q] , @chat.id).records.records
    end
    render json: @response, status: @status
  end

  private
  def get_chat
    @token = params[:application_id]
    @chat_number = params[:chat_id]
    @msg_number = params[:id]

    @app = Application.find_by(token: @token)
    @status = 200
    if @app == nil
      @response = {errors: "app with token #{@token} is not found"}
      @status = 404
    else
      @chat = @app.chats.find_by(number: @chat_number)
      if @chat == nil 
        @response = {errors: "chat with number #{@chat_number} is not found"}
        @status = 404
      end
    end
  end

end
