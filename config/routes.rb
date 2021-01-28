Rails.application.routes.draw do
  get 'sessions/new'
  get '/about' => 'static_pages#about'
  get '/contact' => 'static_pages#contact'
  root 'static_pages#home'
  get '/signup' => 'users#new'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'
  resources :users
end
