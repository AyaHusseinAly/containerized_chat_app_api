Rails.application.routes.draw do

  resources :applications, only: [:create, :index, :update, :show] do
    resources :chats, only: [:create, :index, :show] do
      resources :messages, only: [:create, :index, :update, :show]
    end
  end
  get 'items/search', to: 'items#search'

  # resources :chats, only: [:create, :index, :update, :show]
  # resources :messages, only: [:create, :index, :update, :show, :search]

  # get 'messages/index'

  # get 'messages/create'

  # get 'messages/update'

  # get 'messages/show'

  # get 'messages/search'

  # get 'chats/index'

  # get 'chats/create'

  # get 'chats/update'

  # get 'chats/show'

  # get 'applications/index'

  # get 'applications/create'

  # get 'applications/update'

  # get 'applications/show'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
