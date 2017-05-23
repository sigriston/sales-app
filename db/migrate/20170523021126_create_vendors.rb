class CreateVendors < ActiveRecord::Migration[5.1]
  def change
    create_table :vendors do |t|
      t.string :name, null: false
      t.string :address, null: false

      t.timestamps
    end
    add_index :vendors, [:name, :address], unique: true
  end
end
