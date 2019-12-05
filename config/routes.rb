Rails.application.routes.draw do
  root 'basic_pages#home'
  get 'basic_pages/home'
  devise_for :users
  get 'transactions/debtor_new', to: 'transactions#debtor_new'
  post 'transactions/debtor_create', to: 'transactions#debtor_create'
  get 'transactions/creditor_new', to: 'transactions#creditor_new'
  post 'transactions/creditor_create', to: 'transactions#creditor_create'
  resources :transactions, only: [:index, :edit, :show, :update, :destroy]
end
