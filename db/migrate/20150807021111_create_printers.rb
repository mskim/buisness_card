class CreatePrinters < ActiveRecord::Migration
  def change
    create_table :printers do |t|
      t.string :name
      t.string :contact
      t.string :email
      t.string :cell
      t.integer :agent_id

      t.timestamps null: false
    end
  end
end
