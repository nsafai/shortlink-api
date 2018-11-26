Rails.application.routes.draw do
  root to: 'shortlinks#index'
  get '/:short_url', to: 'shortlinks#redir'
  devise_for :users
  resources :users
  resources :shortlinks
end
