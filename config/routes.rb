Rails.application.routes.draw do
  resources :pizzas
  resources :toppings
  root 'pizzas#home'
end
