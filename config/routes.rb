Rails.application.routes.draw do
  root 'homepages#index'
  resources :drivers

  resources :passengers do
    resources :trips, only: %i[create new index]
  end
  resources :trips
  patch 'passengers/:id/complete_trip', to: 'trip#complete_trip', as: 'complete_trip'
end
