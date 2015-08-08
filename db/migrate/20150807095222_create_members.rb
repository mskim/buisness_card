class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :name
      t.string :email
      t.text :variables
      t.integer :company_id

      t.timestamps null: false
    end
  end
end
