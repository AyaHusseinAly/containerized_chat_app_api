class ChatsController < ApplicationController
  def index
    render json: Chat.all()
  end

  def create
  end

  def update
  end

  def show
  end
end
