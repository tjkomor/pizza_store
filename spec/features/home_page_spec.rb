require 'rails_helper'

RSpec.feature "Pizza management", type: :feature do
  before(:each) do
    Pizza.destroy_all
    Topping.destroy_all
  end

  scenario 'User clicks on pizza manager' do
    visit '/'
    click_on 'Pizza Manager'

    expect(page).to have_current_path(pizzas_path)
  end
  
  scenario 'User clicks on toppings manager' do
    visit '/'
    click_on 'Toppings Manager'

    expect(page).to have_current_path(toppings_path)
  end
  
  scenario 'User can see the menu' do
    topping = Topping.create!(name: "Mushrooms")
    topping2 = Topping.create!(name: "Pineapple")
    pizza = Pizza.create!(name: 'ew', toppings: [topping])
    visit '/'
    click_on 'Toppings Manager'

    expect(page).to have_text("Mushrooms")
    expect(page).to have_text("Pineapple")
    expect(page).to have_text("Menu")
    expect(page).to have_text("ew")
  end
end