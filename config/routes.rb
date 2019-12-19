Rails.application.routes.draw do

  get 'admin' => 'admin#index'

  controller :sessions do
    get 'login'  => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end

  root 'store#index', as: 'store_index'
  resources :line_items, only: [:create, :destroy] do
  	member do
	   patch :increase
	   patch :decrease
	end
  end
  resources :carts, only: [:show, :create, :destroy]
  resources :products do
    get :who_bought, on: :member
  end
  resources :orders, only: [:new, :create, :index]

  resources :users
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
