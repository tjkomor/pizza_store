require 'rails_helper'

RSpec.feature "Topping management", type: :feature do
  scenario "User creates a new topping" do
    visit "/toppings/new"

    fill_in "Name", with: "Mushrooms"
    click_button "Create Topping"

    expect(page).to have_text("Topping was successfully created.")
    expect(page).to have_text("mushrooms")
  end

  scenario "User edits a topping" do
    topping = Topping.create!(name: "Mushrooms")

    visit "/toppings/#{topping.id}/edit"

    fill_in "Name", with: "Onions"
    click_button "Update Topping"

    expect(page).to have_text("Onions")
  end

  scenario "User deletes a topping", js: true do
    topping = Topping.create!(name: "Mushrooms")

    visit "/toppings"

    within("#topping_#{topping.id}") do
      click_button 'Delete'
    end

    visit "/pizzas"
    
    expect(page).to_not have_text('Mushrooms')
  end
  
  scenario "User marks a topping as out of stock", js: true do
    topping = Topping.create!(name: "Mushrooms")

    visit "/toppings"

    within("#topping_#{topping.id}") do
      click_button 'Mark as Out of Stock'
    end

    within(".out-of-stock") do
      expect(page).to have_text('Mushrooms')
    end
    
    within(".in-stock") do
      expect(page).to_not have_text('Mushrooms')
    end
  end
  
  scenario "User marks a topping as in stock", js: true do
    topping = Topping.create!(name: "Mushrooms")

    visit "/toppings"

    within("#topping_#{topping.id}") do
      click_button 'Mark as Out of Stock'
    end

    within(".out-of-stock") do
      expect(page).to have_text('Mushrooms')
      click_button 'Mark as In Stock'
    end
    
    within(".in-stock") do
      expect(page).to have_text('Mushrooms')
    end

    within(".out-of-stock") do
      expect(page).to_not have_text('Mushrooms')
    end
  end
end
