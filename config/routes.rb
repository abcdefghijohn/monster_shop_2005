Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  def put(*) end
  root "welcome#index"

  resources :merchants

  resources :items, only: %i[index show edit update destroy]

  resources :merchants do
    resources :items
  end

  resources :items, only: %i[new create] do
    resources :reviews, only: %i[new create]
  end

  resources :items, only: %i[new create] do
    resources :reviews, only: %i[new create]
  end

  resources :reviews, only: %i[edit update destroy]

  post "/cart/:item_id", to: "cart#add_item"
  get "/cart", to: "cart#show"
  delete "/cart", to: "cart#empty"
  delete "/cart/:item_id", to: "cart#remove_item"
  patch "/cart/:item_id", to: "cart#modify_quantity"

  resources :orders, only: %i[new create]

  namespace :merchant do
    resources :orders, only: %i[show]
    resources :items
    resources :discounts, only: %i[index show update destroy new create edit]
  get "/", to: "dashboard#show"
  patch "/itemorders/:itemorder_id", to: "item_orders#update"
  post "/items/deactivate", to: "items#deactivate"
  post "/items/activate", to: "items#activate"
  end

  namespace :admin do
    resources :merchants, only: %i[index]
    resources :users, only: %i[index show]
    patch '/merchants/disable', to: "merchants#disable"
    patch '/merchants/enable', to: "merchants#enable"
    get '/', to: "dashboard#index"
    get '/users/:id', to: "users#show"
    patch '/:order_id', to: "profile_orders#update"
    get '/merchants/:merchant_id', to: 'merchants#show'
  end

  resources :users, only: %i[create]

  get "/register", to: "users#new"


  get "/profile", to: "users_dashboard#show"
  get "/profile/edit", to: "users_dashboard#edit"
  patch "/profile", to: "users_dashboard#update"

  get '/profile/orders', to: "profile_orders#index"
  get '/profile/orders/:id', to: "profile_orders#show"
  patch "/profile/orders/:id", to: "profile_orders#cancel"


  get "/password/edit", to: "passwords#edit"
  patch "/password", to: "passwords#update"



  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: 'sessions#destroy'

end
