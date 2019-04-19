Rails.application.routes.draw do
  root 'homepages#index'
  resources :drivers
  patch '/drivers/:id/available', to: 'drivers#available', as: 'available'
  resources :passengers do
    resources :trips, only: %i[create new index]
  end
  resources :trips
  patch 'passengers/:id/complete_trip', to: 'trips#complete_trip', as: 'complete_trip'
end
