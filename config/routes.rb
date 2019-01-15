Rails.application.routes.draw do
  resources :comments
  resources :posts
  resources :authors
  get 'landing/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'landing#index' # Add this line

  get 'polynomials/new', to: 'polynomials#new'
  get 'polynomials/:id', to: 'polynomials#show'
  post 'polynomials', to: 'polynomials#create'
end
