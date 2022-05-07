class Chat < ApplicationRecord
  belongs_to :application
  has_many :messages, dependent: :destroy
  after_create :update_chat_count
  # before_create :generate_number

  private
  def update_chat_count
    self.application.chat_count += 1
    self.application.save()
  end

  # private
  # def generate_number
  #   app_chat_count = Chat.group(:application_id).maximum("number")[self.application_id]
  #   self.number =  app_chat_count == nil ? 1 : app_chat_count + 1
  # end
end
