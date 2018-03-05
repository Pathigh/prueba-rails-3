class CreateWorks < ActiveRecord::Migration[5.1]
  def change
    create_table :works do |t|
      t.string :name
      t.string :photo
      t.integer :valor

      t.timestamps
    end
  end
end
