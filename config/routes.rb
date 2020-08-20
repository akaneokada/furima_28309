Rails.application.routes.draw do
  devise_for :users
  root "items#index"
  resources :items do
    resources :transactions, only: [:index, :create]
  end
end