Rails.application.routes.draw do
  root to: "items#index"
  devise_for :users
  resources :items, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
    resources :purchases, only: [:index, :create]
  end
end
