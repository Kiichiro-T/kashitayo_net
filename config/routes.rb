Rails.application.routes.draw do
  root 'basic_pages#home'
  get 'basic_pages/home'
  devise_for :users
  get   'debtor_transactions/:id/approval', to: 'debtor_transactions#approval', as: 'approval_debtor_transaction'
  patch 'debtor_transactions/:id/approve_or_deny', to: 'debtor_transactions#approve_or_deny', as: 'approve_or_deny_debtor_transaction'
  get   'creditor_transactions/:id/approval', to: 'creditor_transactions#approval', as: 'approval_creditor_transaction'
  patch 'creditor_transactions/:id/approve_or_deny', to: 'creditor_transactions#approve_or_deny', as: 'approve_or_deny_creditor_transaction'
  resources :debtor_transactions, only: [:index, :new, :create, :edit, :update, :destroy]
  resources :creditor_transactions, only: [:index, :new, :create, :edit, :update, :destroy]
end
