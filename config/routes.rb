Rails.application.routes.draw do

  resources :applications, only: [:create, :index, :update, :show] do
    resources :chats, only: [:create, :index, :show] do
      resources :messages, only: [:create, :index, :update, :show]
    end
  end
  get 'applications/:application_id/chats/:chat_id/search/messages', to: 'messages#search'

 
end
