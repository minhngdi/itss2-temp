Rails.application.routes.draw do
  post '/rate' => 'rater#create', :as => 'rate'
  devise_for :admins, controllers: {
        sessions: "admins/sessions"
            }
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  mount ActionCable.server => '/cable'

  root "static_pages#home"
  devise_for :users, controllers: {
        registrations: "users/registrations",
        sessions: "users/sessions"
            }

  resources :hotel_reviews

  resources :reports, only: [:new, :create, :index, :destroy]

  resources :hotels do
    resources :comments
  end
  resources :comments do
    resources :comments
  end
  notify_to :users
  resources :users, only: [:show, :index]
  resources :personal_messages, only: [:new, :create]
  resources :conversations, only: [:index, :show]
  mount ActionCable.server => '/cable'
end
