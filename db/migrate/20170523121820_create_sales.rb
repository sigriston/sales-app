class CreateSales < ActiveRecord::Migration[5.1]
  def change
    create_table :sales do |t|
      t.references :customer, foreign_key: true
      t.references :product, foreign_key: true
      t.integer :quantity, null: false

      t.timestamps
    end
  end
end
