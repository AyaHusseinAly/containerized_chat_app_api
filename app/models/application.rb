class Application < ApplicationRecord
    has_many :chats, dependent: :destroy
    validates :name, presence: true
    before_create :generate_token
    after_create :update_redis_data
  
    private
    def generate_token
      self.token = loop do
        random_token = SecureRandom.urlsafe_base64(nil, false)
        break random_token unless Application.exists?(token: random_token)
      end
    end

    private
    def update_redis_data
      REDIS.set(self.token,0)
    end
    
  end
  