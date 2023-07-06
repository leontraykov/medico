Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "pages#main"
  root 'chat_rooms#index'
  resources :chat_rooms, only: [:index, :new, :create, :show] do
    resources :messages, only: [:create]
  end
end
