class Chat < ApplicationRecord
  belongs_to :application
  has_many :messages,dependent: :destroy

  before_create :generate_number
  after_create :update_chat_count


  protected
  def generate_number
    # group().max() return hash >>  {app_id_1=> val1, app_id_2=>val2}
    app_chat_count = Chat.group(:application_id).maximum("number")[self.application_id]
    self.number =  app_chat_count == nil ? 1 : app_chat_count + 1
  end

  protected
  def update_chat_count
    self.application.chat_count += 1
    self.application.save()
  end

end
