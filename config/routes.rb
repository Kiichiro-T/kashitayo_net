Rails.application.routes.draw do
  root 'basic_pages#home'
  get 'basic_pages/home'
  devise_for :users
  resources :transactions
end
