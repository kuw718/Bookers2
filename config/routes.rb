Rails.application.routes.draw do
  resources :books, only: [:new, :create, :index, :show, :destroy, :edit, :update]
  get 'home/about', to: 'homes#about', as: 'about'
  root to: "homes#top"
  devise_for :users
  resources :users, only: [:show, :create, :edit, :index, :update, :destroy]
end