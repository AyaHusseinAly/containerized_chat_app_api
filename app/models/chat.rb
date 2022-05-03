class Chat < ApplicationRecord
  belongs_to :application
  has_many :messages,dependent: :destroy

  before_create :generate_number
  after_create :update_chat_count
 
  protected
  def generate_number
    self.number =  Chat.count == 0? 1 : Chat.maximum("number")+1
    # self.number = Chat.count+1
  end

  protected
  def update_chat_count
    self.application.chat_count += 1
    self.application.save()
  end

end
