class Pizza < ApplicationRecord
  has_many :pizza_toppings, dependent: :destroy
  has_many :toppings, through: :pizza_toppings
  
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validate :unique_toppings_combination

  before_save :downcase_name

  def unique_toppings_combination
    matching_pizza = Pizza.includes(:toppings)
                          .where.not(id: id)
                          .select { |pizza| pizza.topping_ids.sort == topping_ids.sort }
                          .any?
    errors.add(:base, 'A pizza with this combination of toppings already exists.') if matching_pizza
  end

  def in_stock_toppings
    toppings.where(in_stock: true)
  end

  def out_of_stock_toppings
    toppings.where(in_stock: false)
  end
end