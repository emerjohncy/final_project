class CreateAuctions < ActiveRecord::Migration[7.0]
  def change
    create_table :auctions do |t|
      t.references :shoe, null: false, foreign_key: true
      t.text :description
      t.datetime :start_date
      t.datetime :end_date
      t.string :status, default: "Close"
      t.string :payment_method
      t.float :starting_price

      t.timestamps
    end
  end
end
