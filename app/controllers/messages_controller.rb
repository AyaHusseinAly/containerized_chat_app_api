class MessagesController < ApplicationController
  before_action :get_chat, except: [:create]
  before_action :validate_chat_existance , only: [:create]


  def index
    # status equals 200 when before_action method checks that token and chat_number exists
    if @status == 200
      @response = @chat.messages.select(:number, :body, :created_at, :updated_at).to_json(except: :id)
    end
    render json: @response, status: @status
  end
  
  def create
    if @status == 200
      latest_msg_num = REDIS.get(@token+'__'+@chat_number).to_i
      @msg_number = latest_msg_num + 1
      REDIS.set("#{@token}__#{@chat_number}", @msg_number) # increment chat latest_msg_num
      StoreMessagesJob.perform_later(@msg_body, @msg_number, @chat_number, @token)
      @response = {message_number: @msg_number}
    end
    render json: @response, status: @status
  end

  def update
    @msg_number = params[:number]
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
    @msg_number = params[:number]
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
    @token = params[:application_token]
    @chat_number = params[:chat_number]

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

  private 
  def validate_chat_existance
    @status = 200
    @token = params[:application_token]
    @chat_number = params[:chat_number]
    @msg_body = params[:msg_body]
    if @msg_body == nil || @msg_body == ""
      @response = {errors: "msg_body can't be blank"}
      @status = 400
    elsif REDIS.get("#{@token}__#{@chat_number}") == nil 
      @response = {errors: "chat with app token #{@token} & number #{@chat_number} is not found"}
      @status = 404
    end
  end

end
