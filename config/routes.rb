Rails.application.routes.draw do
  resources :users
  resources :sessions
  resources :books

  get 'sessions/new'
  get 'hello_world', to: 'hello_world#index'

  get 'signup', to: 'users#new',        as: 'signup'
  get 'login',  to: 'sessions#new',     as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  root 'welcome#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
