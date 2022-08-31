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

  get "/auctions", to: "auctions#index"
  get "/bids", to: "bids#index"
  get "/:auction_id/history_bids", to: "bids#history_bids", as: "history_bids"
  root "pages#home"
  
end
