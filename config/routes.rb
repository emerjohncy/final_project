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
      resources :bids
    end
  end

  get "/auctions", to: "auctions#index"
  root "pages#home"
  
end
