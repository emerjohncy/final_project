class CreateShoes < ActiveRecord::Migration[7.0]
  def change
    create_table :shoes do |t|
      t.references :user
      t.text :condition
      t.string :color
      t.string :model
      t.string :brand
      t.float :starting_price

      t.timestamps
    end
  end
end
