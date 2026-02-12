Rails.application.routes.draw do
  devise_for :users

  root 'tweets#index'

  resources :tags
  resources :users, only: [:show]

  get "tweets/list", to: "tweets#list", as: "tweets_list"

  resources :tweets do
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end
end
