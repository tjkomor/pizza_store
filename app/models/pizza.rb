class Pizza < ApplicationRecord
  has_many :pizza_toppings, dependent: :destroy
  has_many :toppings, through: :pizza_toppings
  
  validates :name, presence: true, uniqueness: true
  validate :unique_toppings_combination

  def unique_toppings_combination
    existing_pizzas = Pizza.includes(:toppings) # include toppings to avoid N+1 query problem
    existing_pizzas.each do |pizza|
      if pizza.toppings.ids.sort == self.topping_ids.sort
        errors.add(:base, 'A pizza with this combination of toppings already exists.')
        break
      end
    end
  end
end