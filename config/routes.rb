Rails.application.routes.draw do
  devise_for :users
  resources :users
  root to: 'shortlinks#index'
  resources :shortlinks
  get '/:short_url', to: 'shortlinks#redir'
end
