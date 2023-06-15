# spec/features/topping_management_spec.rb

require 'rails_helper'

RSpec.feature "Topping management", type: :feature do
  scenario "User creates a new topping" do
    visit "/toppings/new"

    fill_in "Name", with: "Mushrooms"
    click_button "Create Topping"

    expect(page).to have_text("Topping was successfully created.")
    expect(page).to have_text("Mushrooms")
  end

  scenario "User edits a topping" do
    topping = Topping.create!(name: "Mushrooms")

    visit "/toppings/#{topping.id}/edit"

    fill_in "Name", with: "Onions"
    click_button "Update Topping"

    expect(page).to have_text("Topping was successfully updated.")
    expect(page).to have_text("Onions")
  end
end
