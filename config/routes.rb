Rails.application.routes.draw do
  root to: 'shortlinks#index'
  devise_for :users
  resources :users
  resources :shortlinks
end
