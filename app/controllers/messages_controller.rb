class MessagesController < ApplicationController
  def index
    render json: Message.all()
  end

  def create
  end

  def update
  end

  def show
  end

  def search
  end
end
