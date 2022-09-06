Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  devise_scope :user do
    get '/profile' => 'pages#profile',
      as: 'profile'
    get '/profile/edit' => 'users/registrations#edit'

  end
  
  devise_for :admins
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :shoes do
    resources :auctions, except: :index do
      resources :bids, except: :index
    end
  end

  get "/selling", to: "auctions#index", as: "selling"
  get "/open_auctions", to: "auctions#open_auctions"
  get "/buying", to: "bids#index", as: "buying"
  get "/:auction_id/history_bids", to: "bids#history_bids", as: "history_bids"
  root "pages#home"

  get "/faq" => "pages#faq", as: "faq"
  get "/buying_selling" => "pages#buying_selling"
  
end
