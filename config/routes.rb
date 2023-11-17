Rails.application.routes.draw do
  devise_for :users
  get '/sign_in', to: 'sessions#new', as: 'sign_in'
  
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create]do
    resources :comments , only:[:index, :new, :create]
    resources :likes , only:[:create]
    end
  end

  # Defines the root path route ("/")
  root to: "users#index"
end
