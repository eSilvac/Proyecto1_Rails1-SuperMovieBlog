Rails.application.routes.draw do
  root 'post#index'
  devise_for :users
  resources :post
end
