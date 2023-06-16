class Topping < ApplicationRecord
  has_many :pizza_toppings
  has_many :pizzas, through: :pizza_toppings
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  before_save :downcase_name

  def self.create_or_update(topping_params)
    topping_name = topping_params[:name].downcase
    topping = find_by(name: topping_name)

    if topping
      if !topping.in_stock
        topping.update(in_stock: true)
        return topping, 'Topping is now back in stock.'
      else
        return topping, 'Topping already exists and is in stock.'
      end
    else
      topping = new(topping_params)
      if topping.save
        return topping, 'Topping was successfully created.'
      else
        return topping, 'Failed to create topping.'
      end
    end
  end

  private

  def downcase_name
    self.name = name.downcase
  end
end
