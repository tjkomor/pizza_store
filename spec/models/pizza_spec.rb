require 'rails_helper'

RSpec.describe Pizza, type: :model do
  describe 'validations' do
    it 'validates presence of name' do
      pizza = Pizza.new
      expect(pizza.valid?).to eq(false)
      expect(pizza.errors[:name]).to include("can't be blank")
    end

    it 'validates uniqueness of name' do
      Pizza.create!(name: 'Margarita')
      pizza = Pizza.new(name: 'Margarita')
      expect(pizza.valid?).to eq(false)
      expect(pizza.errors[:name]).to include("has already been taken")
    end

    it 'validates uniqueness of toppings' do
      topping1 = Topping.create!(name: 'Mushroom')
      topping2 = Topping.create!(name: 'Onion')
      Pizza.create!(name: 'Mushroom & Onion', toppings: [topping1, topping2])
      pizza = Pizza.new(name: 'Another Mushroom & Onion', toppings: [topping1, topping2])
      expect(pizza.valid?).to eq(false)
      expect(pizza.errors[:base]).to include('A pizza with this combination of toppings already exists.')
    end
  end
end
