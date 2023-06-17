require 'rails_helper'

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

  it 'downcases the name on create' do
    topping = Topping.create!(name: 'PotatO')
    expect(topping.valid?).to eq(true)
    expect(topping.name).to eq('potato')
  end
  
  it 'is not valid with a duplicate name with different capitalization' do
    Topping.create!(name: 'Pepperoni')
    topping = Topping.new(name: 'PeppeRoNi')
    
    expect(topping).to_not be_valid
  end
  
  it "can be marked as out of stock" do
    topping = Topping.create(name: 'Mushrooms', in_stock: true)
    topping.update(in_stock: false)
  
    expect(topping.reload.in_stock).to eq(false)
  end
  
  it "remains associated with pizzas when marked out of stock" do
    topping = Topping.create(name: 'Mushrooms', in_stock: true)
    pizza = Pizza.create(name: 'Veggie', topping_ids: [topping.id])
    topping.update(in_stock: false)
  
    expect(pizza.toppings).to include(topping)
  end
  
  describe '.create_or_update' do
    context 'when the topping does not exist' do
      it 'creates a new topping' do
        topping_name = 'Mushrooms'
        topping, _ = Topping.create_or_update(name: topping_name)
        
        expect(topping).to be_persisted
        expect(topping.name).to eq(topping_name.downcase)
        expect(topping.in_stock).to be_truthy
      end
    end

    context 'when the topping exists and is not in stock' do
      it 'updates the topping to be in stock' do
        topping_name = 'Olives'
        Topping.create!(name: topping_name, in_stock: false)
        topping, _ = Topping.create_or_update(name: topping_name)

        expect(topping).to be_persisted
        expect(topping.in_stock).to be_truthy
      end
    end

    context 'when the topping exists and is in stock' do
      it 'does not change the in_stock status' do
        topping_name = 'Pepperoni'
        Topping.create!(name: topping_name, in_stock: true)
        topping, _ = Topping.create_or_update(name: topping_name)

        expect(topping).to be_persisted
        expect(topping.in_stock).to be_truthy
      end
    end
  end

  describe 'Delete' do 
    it "is removed from pizzas when deleted" do
      topping = Topping.create(name: 'Mushrooms', in_stock: true)
      pizza = Pizza.create(name: 'Veggie', topping_ids: [topping.id])
      topping.destroy

      pizza.reload
    
      expect(pizza.toppings).to_not include(topping)
    end
  end
end


