Rails.application.routes.draw do
  root to: 'toppages#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  
  resources :users do
    member do
      get :followings
      get :followers
      get :likes
    end
  end
  
  resources :posts, only: [:create, :destroy]
  resources :relations, only: [:create, :destroy]
  resources :likes, only: [:create, :destroy]
end