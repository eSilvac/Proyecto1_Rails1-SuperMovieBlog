Rails.application.routes.draw do


  root 'posts#index'

  get 'userposts' => 'userposts#show' 

  devise_for :users
  resources :posts do
  	resources :comments , only: [:create, :destroy]

  end
end
