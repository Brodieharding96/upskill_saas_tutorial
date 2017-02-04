Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    get 'sign-up', to: 'devise/registrations#new'
  end
  root to: 'pages#home'
  get 'about', to: 'pages#about'
  resources :contacts, only: :create
  get 'contact-us', to: 'contacts#new', as: 'new_contact'
end
