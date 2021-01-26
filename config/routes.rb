Rails.application.routes.draw do
  get 'about' => 'static_pages#about'
  get 'static_pages/help'
  root 'static_pages#home'
  resources :users
end
