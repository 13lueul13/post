Rails.application.routes.draw do
  get 'likes/create'

  get 'likes/destroy'

  root to: 'toppages#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  resources :users, only: [:index, :show, :new, :create] do
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