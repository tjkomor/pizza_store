require 'rails_helper'

RSpec.describe Topping, type: :model do
  it 'can be created' do
    topping = Topping.new(name: "Jalapeno")
    expect(topping).to be_valid
  end
  
  it 'is not valid without a name' do
    topping = Topping.new(name: nil)
    expect(topping).to_not be_valid
  end

  it 'is not valid with a duplicate name' do
    Topping.create!(name: 'Pepperoni')
    topping = Topping.new(name: 'Pepperoni')
    expect(topping).to_not be_valid
  end
  
  it 'is not valid with a duplicate name with different capitalization' do
    Topping.create!(name: 'Pepperoni')
    topping = Topping.new(name: 'PeppeRoNi')
    expect(topping).to_not be_valid
  end
end
