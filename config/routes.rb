Rails.application.routes.draw do
  devise_for :users
  devise_for :admins
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :shoes do
    resources :auctions, except: :index do
      resources :bids
    end
  end

  root "shoes#index"

  get "/auctions", to: "auctions#index"
  
end
