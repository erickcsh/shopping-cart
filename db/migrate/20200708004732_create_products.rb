class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.string :uuid, unique: true, null: false
      t.decimal :price, null: false
      t.boolean :available, default: true, null: false

      t.timestamps
    end
  end
end
