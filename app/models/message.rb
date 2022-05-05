require 'elasticsearch/model'

class Message < ApplicationRecord
  # include Searchable  
  belongs_to :chat
  before_create :generate_number
  after_create :update_msg_count
  validates :body, presence: true
  
  protected
  def generate_number
    chat_msg_count = Message.group(:chat_id).maximum("number")[self.chat_id]
    self.number =  chat_msg_count == nil ? 1 : chat_msg_count + 1
  end

  protected
  def update_msg_count
    self.chat.message_count += 1
    self.chat.save()
  end

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  
  def self.search(query, chat_id)
    __elasticsearch__.search({
      "query": { 
        "bool": { 
          "must": [
            { "match": { "body": query }}
          ],
          "filter": [ 
            { "term":  { "chat_id": chat_id }},
          ]
        }
      }
  })
end
  # def self.search(query)
  #   __elasticsearch__.search(
  #     {
  #       query: {
  #         multi_match: {
  #           query: query,
  #           fuzziness: 1,
  #           fields: ['body']
  #         }
  #       },
  #     }
  #   )
  # end
end
