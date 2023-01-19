Rails.application.routes.draw do
  devise_for :users
  root to: 'books#index'
  resources :books
  resources :users, only: [:index, :show]

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
