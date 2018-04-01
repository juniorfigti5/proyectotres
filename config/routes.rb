Rails.application.routes.draw do
  get 'send/index'

  resources :voices
  resources :statuses
  resources :contests, param: :url
  get 'home/index'
  devise_for :users
  root 'home#index', as: 'home'
  get  '/contests',   to: 'contests#index'
  get  '/voice',  to: 'voices#new'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
 end
