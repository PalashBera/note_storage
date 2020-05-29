Rails.application.routes.draw do
  devise_for :users
  resources :notes, except: :show

  root "home#index"
end
