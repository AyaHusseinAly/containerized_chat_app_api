class ApplicationsController < ApplicationController


  def index
    render json: Application.select(:token, :name, :chat_count, :created_at, :updated_at).to_json(except: :id)
  end

  def create
    @app = Application.create(name: params[:name], chat_count: 0)  
    response = @app.errors.any? ? {errors: @app.errors.full_messages} : {token: @app.token}
    render json: response
  end


  def update
    @token = params[:id]
    @status = 200
    @app = Application.find_by(token: @token) 
    if @app == nil
      @response = {errors: "app with token #{@token} is not found"}
      @status = 404
      
    else
      @app.name = params[:name]
      @app.save()
      @response = @app.to_json(except: :id)      
    end
    render json: @response, status: @status
  end


  def show
    @token = params[:id]
    @status = 200
    @app = Application.find_by(token: @token) 
    if @app == nil
      @response = {errors: "app with token #{@token} is not found"}
      @status = 404
     
    else
      @response = @app.to_json(except: :id)
      
    end
    render json: @response, status: @status
  end

end
