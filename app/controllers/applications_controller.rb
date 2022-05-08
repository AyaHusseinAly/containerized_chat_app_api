class ApplicationsController < ApplicationController
  before_action :get_app, only: [:show, :update]

  def index
    render json: Application.select(:token, :name, :chat_count, :created_at, :updated_at).to_json(except: :id)
  end

  def create
    @app = Application.create(name: params[:name], chat_count: 0)  
    response = @app.errors.any? ? {errors: @app.errors.full_messages} : {token: @app.token}
    render json: response, status: 201
  end


  def update
    if @status == 200
      @app.name = params[:name]
      @app.save()
      @response = @app.to_json(except: :id)      
    end
    render json: @response, status: @status
  end


  def show
    if @status == 200
      @response = @app.to_json(except: :id)
    end
    render json: @response, status: @status
  end

  private
  def get_app
    @token = params[:token]
    @status = 200
    @app = Application.find_by(token: @token) 
    if @app == nil
      @response = {errors: "app with token #{@token} is not found"}
      @status = 404
    end
  end

end
