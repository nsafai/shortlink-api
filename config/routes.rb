Rails.application.routes.draw do
  root to: 'shortlinks#index'
  resources :shortlinks
  get '/:short_url', to: 'shortlinks#redir'
  devise_for :users
  resources :users
end
