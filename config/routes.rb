Rails.application.routes.draw do
  resources :pizzas
  resources :toppings
  root 'application#home'
end
