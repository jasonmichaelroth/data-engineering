class CreateTables < ActiveRecord::Migration
  def change
    create_table :purchasers do |t|
      t.string :name
      t.timestamps
    end

    create_table :items do |t|
      t.string :description
      t.float :price
      t.integer :merchant_id
    end

    create_table :merchants do |t|
      t.string :name
      t.string :address
    end

    create_table :purchases do |t|
      t.integer :purchaser_id
      t.integer :item_id
      t.integer :num_items
    end

  end
end
