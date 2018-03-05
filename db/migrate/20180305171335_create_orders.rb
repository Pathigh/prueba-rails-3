class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.boolean :listo, default: false
      t.integer :quantity, default: 1
      t.references :user, foreign_key: true
      t.references :work, foreign_key: true

      t.timestamps
    end
  end
end
