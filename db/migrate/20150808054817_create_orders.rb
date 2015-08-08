class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :member_id
      t.integer :quantity
      t.string :status
      t.string :delivery

      t.timestamps null: false
    end
  end
end
