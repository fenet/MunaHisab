class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
    	t.references :catagory, index: true, foreign_key: true
        t.string :created_by, null: false
    	t.string :product_name, index: true, null: false
    	t.string :photo
    	t.decimal :unit_price, null: false
    	t.text :description
    	t.string :serial_number
    	t.integer :quantity, null: false
    	t.decimal :selling_price
    	t.string :type_of_sales
        t.timestamps
    end
  end
end
