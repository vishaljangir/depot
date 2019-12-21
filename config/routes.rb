Rails.application.routes.draw do

  get 'admin' => 'admin#index'

  controller :sessions do
    get 'login'  => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end
  
  resources :line_items, only: [:create, :destroy] do
    patch :decrease, on: :member
  end
  resources :carts, only: [:show, :create, :destroy]

  scope '(:locale)' do
    
    root 'store#index', as: 'store_index'

    resources :orders, only: [:new, :create, :index]
  end

  resources :products do
    get :who_bought, on: :member
  end

  resources :users
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
