Rails.application.routes.draw do
  root 'basic_pages#home'
  get 'basic_pages/home'
  devise_for :users
  resources :debtor_transactions, only: [:index, :new, :create, :edit, :update, :destroy]
  resources :creditor_transactions, only: [:index, :new, :create, :edit, :update, :destroy]
end
