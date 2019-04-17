Rails.application.routes.draw do
  resources :drivers do
    resources :trips
  end
  resources :passengers
  resources :trips
end
