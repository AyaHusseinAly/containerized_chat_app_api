class MessagesController < ApplicationController
  def index
    @token = params[:application_id]
    @chat_number = params[:chat_id]

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
      else
        @response = @chat.messages.select(:number, :body, :created_at, :updated_at).to_json(except: :id)
      end
    end
    render json: @response, status: @status
  end
  
  def create
    @token = params[:application_id]
    @chat_number = params[:chat_id]

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
      else
        @msg = @chat.messages.create(body: params[:msg_body])
        @response = @msg.errors.any? ? {errors: @msg.errors.full_messages} : {message_number: @msg.number}
      end
    end
    render json: @response, status: @status
  end

  def update
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
      else
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
    end
    render json: @response, status: @status
  end


  def show
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
      else
        @msg = @chat.messages.find_by(number: @msg_number)
        if @msg == nil
          @response = {errors: "message with number #{@msg_number} is not found"}
          @status = 404
        else
          @response = @msg.to_json(except: [:id,:chat_id])
        end
      end
    end
    render json: @response, status: @status
  end

  def search
    render json: Message.search('hi')#.records
  end
end
