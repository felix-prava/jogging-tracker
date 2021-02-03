Rails.application.routes.draw do
  get 'sessions/new'
  get '/contact' => 'static_pages#contact'
  root 'static_pages#home'
  get '/signup' => 'users#new'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'
  get '/order' => 'users#order'
  get '/report' => 'users#report'
  resources :users
  resources :jogtimes
end
