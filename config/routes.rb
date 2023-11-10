Rails.application.routes.draw do
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create]do
    resources :comments , only:[:index, :new, :create]
    resources :likes , only:[:create]
    end
  end

  resources :posts, only: [:index, :show]

  # Defines the root path route ("/")
  root to: "users#index"
end
