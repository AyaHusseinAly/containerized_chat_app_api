class ApplicationsController < ApplicationController

  def index
    render json: Application.all()
  end

  def create
    @app = Application.create(name: params[:name], chat_count: 0)
    response = params[:name].present? ? {token: @app.token} : {error:"missing application name"}
    render json: response
  end

  def update
    token = params[:id]
    @app = Application.find_by(token: token)
    if params[:name].present?
      @app.name = params[:name]
      @app.save()
      response = {app: @app} 
    else
      response = {error:"missing application name"}
    end
    render json: response
  end

  def show
    token = params[:id]
    @app = Application.find_by(token: token)
    render json: {app: @app}
  end

end
