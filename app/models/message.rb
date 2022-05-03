class Message < ApplicationRecord
  belongs_to :chat
  before_create :generate_number
  # after_create :update_msg_count
  
  protected
  def generate_number
    self.number =  Message.count == 0 ? 1 : Message.maximum("number")+1
  end

  
end
