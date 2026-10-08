Rails.application.routes.draw do
 
  get "up" => "rails/health#show", as: :rails_health_check


  root "sessions#new"
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"

  get "/signup", to: "school_admins#new"
  post "/signup", to: "school_admins#create"

  
  resources :schools do
    resources :students, only: [:index, :new, :create] do
      resources :attendances
    end
    resources :school_admins, only: [:new, :create]
  end

  
  resources :students, only: [:show, :edit, :update, :destroy] do
    resources :attendances
  end

  
  resources :school_admins, only: [:show, :edit, :update]

  resources :password_resets, only: [:new, :create, :edit, :update]
end