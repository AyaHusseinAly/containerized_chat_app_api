require 'elasticsearch/model'

class Message < ApplicationRecord
  belongs_to :chat
  after_create :update_msg_count
  validates :body, presence: true


  private
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
            { "fuzzy": { "body": query}}
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
