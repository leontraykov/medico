# frozen_string_literal: true

Rails.application.routes.draw do
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    get 'pages/home'
    devise_for :users
    resources :users
    # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

    # Defines the root path route ("/")
    root "pages#home"
    # root 'chat_rooms#index'
    resources :chat_rooms, only: %i[index new create show] do
      resources :messages, only: [:create]
    end

    resources :questions, only: [:index, :create]
  end
end
