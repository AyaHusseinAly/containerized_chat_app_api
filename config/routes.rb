Rails.application.routes.draw do

  resources :applications, only: [:create, :index, :update, :show], :param => :token do
    resources :chats, only: [:create, :index, :show], :param => :number do
      resources :messages, only: [:create, :index, :update, :show], :param => :number
    end
  end
  get 'applications/:application_token/chats/:chat_number/search/messages', to: 'messages#search'

  mount ActionCable.server => "/cable"

end
