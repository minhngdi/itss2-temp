Rails.application.routes.draw do
  get 'random_rate', to: 'random_rate#index'
  get 'informations/show'
  get '/compares', to: 'compares#index'
  get '/compares/:id', to: 'compares#show'
  
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

  resources :hotels, path: :recommends do
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
