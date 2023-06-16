class AddInStockToToppings < ActiveRecord::Migration[7.0]
  def change
    add_column :toppings, :in_stock, :boolean, default: true
  end
end