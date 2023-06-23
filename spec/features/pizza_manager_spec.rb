require 'rails_helper'

RSpec.feature "Pizza management", type: :feature do
  before(:each) do
    Pizza.destroy_all
    Topping.destroy_all
  end

  context "Create" do
    scenario "User creates a new pizza" do
      topping = Topping.create!(name: "Mushrooms")
      visit "/pizzas/new"
  
      fill_in "Pizza Name", with: "New Pizza"
  
      check("pizza[topping_ids][]", option: topping.id)
  
      click_button "Create Pizza"
  
      expect(page).to have_text("Pizza was successfully created")
    end
    
    scenario "User cannot create another pizza with the same name" do
      topping = Topping.create!(name: "Mushrooms")
      topping2 = Topping.create!(name: "Pineapple")
      pizza = Pizza.create!(name: 'ew', toppings: [topping])
      count = Pizza.count
      visit "/pizzas/new"
  
      fill_in "Pizza Name", with: "ew"
  
      click_button "Create Pizza"
  
      expect(page).to have_text("Name has already been taken")
      expect(Pizza.count).to eq(count)
    end
    
    scenario "User cannot create another pizza with the same toppings combo" do
      topping = Topping.create!(name: "Mushrooms")
      topping2 = Topping.create!(name: "Pineapple")
      pizza = Pizza.create!(name: 'ew', toppings: [topping, topping2])
      count = Pizza.count
      visit "/pizzas/new"
  
      fill_in "Pizza Name", with: "version 2"
      check("pizza[topping_ids][]", option: topping.id)
      check("pizza[topping_ids][]", option: topping2.id)
  
      click_button "Create Pizza"
  
      expect(page).to have_text("A pizza with this combination of toppings already exists.")
      expect(Pizza.count).to eq(count)
    end
  end

  context "Edit" do
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
    
    scenario "User edits the name of a pizza to name that already exists" do
      Pizza.create!(name: 'not great pizza')
      topping = Topping.create!(name: "Mushrooms")
      Topping.create!(name: "Pineapple")
      pizza = Pizza.create!(name: 'ew', toppings: [topping])
      visit "/pizzas/#{pizza.id}/edit"
  
      fill_in "Pizza Name", with: "not great pizza"
  
      click_button "Update Pizza"
  
      expect(page).to_not have_text("Pizza was successfully updated")
    end
    
    scenario "User edits the combination of a pizza" do
      topping = Topping.create!(name: "Mushrooms")
      topping2 = Topping.create!(name: "Pineapple")
      pizza = Pizza.create!(name: 'ew', toppings: [topping])
      visit "/pizzas/#{pizza.id}/edit"
  
      check("pizza[topping_ids][]", option: topping2.id)
  
      click_button "Update Pizza"
  
      expect(page).to have_text("Pizza was successfully updated")
      expect(page).to have_text("mushrooms")
      expect(page).to have_text("pineapple")
    end
    
    scenario "User tries to edit a pizza with a topping combo that already exists" do
      topping = Topping.create!(name: "Mushrooms")
      topping2 = Topping.create!(name: "Pineapple")
      pizza = Pizza.create!(name: 'ew', toppings: [topping])
      Pizza.create!(name: 'something', toppings: [topping, topping2])
      visit "/pizzas/#{pizza.id}/edit"
  
      check("pizza[topping_ids][]", option: topping2.id)
  
      click_button "Update Pizza"
  
      expect(page).to have_text("A pizza with this combination of toppings already exists.")
    end
    
    scenario "User tries to edit a pizza to a name that already exists" do
      topping = Topping.create!(name: "Mushrooms")
      topping2 = Topping.create!(name: "Pineapple")
      pizza = Pizza.create!(name: 'ew', toppings: [topping])
      Pizza.create!(name: 'something', toppings: [topping, topping2])
      visit "/pizzas/#{pizza.id}/edit"
  
      fill_in "Pizza Name", with: "something"
  
      click_button "Update Pizza"
  
      expect(page).to have_text("Name has already been taken")
    end
  end
  
  context "Delete" do
    scenario "User deletes a pizza" do
      topping = Topping.create!(name: "Mushrooms")
      Pizza.create!(name: 'something', toppings: [topping])
      count = Pizza.count
      visit "/pizzas"
    
      click_button "Delete"
  
      expect(page).to_not have_text("Something")
      expect(page).to_not have_text("Mushrooms")
      expect(Pizza.count).to eq(count - 1)
    end
  end
end

 