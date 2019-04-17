Rails.application.routes.draw do
  root 'homepages#index'
  resources :drivers
  resources :passengers do
    resources :trips, except: [:destroy]
  end
  resources :trips, only: [:destroy]
end
