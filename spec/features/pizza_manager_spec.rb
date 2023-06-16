require 'rails_helper'

RSpec.feature "Pizza management", type: :feature do
  before(:each) do
    Pizza.destroy_all
    Topping.destroy_all
  end

  scenario "User creates a new pizza" do
    topping = Topping.create!(name: "Mushrooms")
    visit "/pizzas/new"

    fill_in "Pizza Name", with: "New Pizza"

    check("pizza[topping_ids][]", option: topping.id)

    click_button "Create Pizza"

    expect(page).to have_text("Pizza was successfully created")
  end
  
  scenario "User edits the name of a pizza" do
    topping = Topping.create!(name: "Mushrooms")
    Topping.create!(name: "Pineapple")
    pizza = Pizza.create!(name: 'ew', toppings: [topping])
    visit "/pizzas/#{pizza.id}/edit"

    fill_in "Pizza Name", with: "not great pizza"

    click_button "Update Pizza"

    expect(page).to have_text("Pizza was successfully updated")
    expect(page).to have_text("not great pizza")
  end
end

 