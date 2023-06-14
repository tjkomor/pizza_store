class Pizza < ApplicationRecord
  has_many :pizza_toppings
  has_many :toppings, through: :pizza_toppings

  accepts_nested_attributes_for :toppings, allow_destroy: true

  TOPPINGS = ['Pepperoni', 'Mushrooms', 'Onions', 'Sausage', 'Bacon', 'Extra cheese', 'Black olives', 'Green peppers', 'Pineapple', 'Spinach']
end