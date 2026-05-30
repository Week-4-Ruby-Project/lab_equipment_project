Rails.application.routes.draw do
  resources :categories, only: [:index, :show, :create, :update, :destroy]
  get "up" => "rails/health#show", as: :rails_health_check

  resources :equipment
end
