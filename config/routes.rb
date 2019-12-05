Rails.application.routes.draw do
  root 'basic_pages#home'
  get 'basic_pages/home'
  devise_for :users
  get 'transactions/debtor_new', to: 'transactions#debtor_new'
  get 'transactions/creditor_new', to: 'transactions#creditor_new'
  resources :transactions, only: [:index, :create, :edit, :show, :update, :destroy]
end
