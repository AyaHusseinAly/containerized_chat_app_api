class StoreChatsJob < ApplicationJob
  queue_as :default

  def perform(*args)
    @chat_number, @token = args
    @app = Application.find_by(token: @token)
    @app.chats.create(number: @chat_number, message_count: 0)
  end
end
