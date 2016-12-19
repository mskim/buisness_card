class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name
      t.text :script
      t.text :variables
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
