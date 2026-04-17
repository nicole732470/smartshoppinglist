Rails.application.routes.draw do
  root 'products#index'
  resources :products do
    resources :price_records, only: [:new, :create]
  end
  resources :price_records, only: [:index, :show, :edit, :update, :destroy]
end