class StoreMessagesJob < ApplicationJob
  queue_as :default

  def perform(*args)
    @msg_body, @msg_number, @chat_number, @token = args
    @app = Application.find_by(token: @token)
    @chat = @app.chats.find_by(number: @chat_number)
    @msg = @chat.messages.create( number: @msg_number, body: @msg_body)
  end
end
