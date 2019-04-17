Rails.application.routes.draw do
  root 'homepages#index'
  resources :drivers do
    resources :trips, except: [:destroy]
  end
  
  resources :passengers do
    resources :trips, only: %i[create new index]
  end
  resources :trips
end
