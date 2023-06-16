require 'rails_helper'

RSpec.feature "Pizza management", type: :feature do
  scenario "User creates a new pizza" do
    topping = Topping.create!(name: "Mushrooms")
    visit "/pizzas/new"

    fill_in "Pizza Name", with: "New Pizza"

    check("pizza[topping_ids][]", option: topping.id)

    click_button "Create Pizza"

    expect(page).to have_text("Pizza was successfully created")
  end
end

 