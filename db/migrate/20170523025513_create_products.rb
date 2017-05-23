class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :description, null: false
      t.decimal :price, null: false
      t.references :vendor, foreign_key: true

      t.timestamps
    end
    add_index :products, [:description, :vendor_id], unique: true
  end
end
