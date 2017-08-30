Rails.application.routes.draw do
  get 'signup', to: 'users#new',        as: 'signup'
  get 'login',  to: 'sessions#new',     as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  get 'sessions/new'
  get 'dashboard/index'

  resources :users
  resources :sessions
  resources :books

  root 'welcome#index'
end
