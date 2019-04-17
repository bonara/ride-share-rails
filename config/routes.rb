Rails.application.routes.draw do
  root 'homepages#index'
  resources :drivers do
    resources :trips, except: [:destroy]
  end
  
  resources :passengers do
    resources :trips, except: %i[create new]
  end
  resources :trips, only: [:destroy]
end
