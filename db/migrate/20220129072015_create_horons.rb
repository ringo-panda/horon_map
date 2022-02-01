class CreateHorons < ActiveRecord::Migration[6.1]
  def change
    create_table :horons do |t|
      t.integer :work_space_id
      t.string :name
      t.integer :parent_id
      t.integer :last_update_user_id

      t.timestamps
    end
  end
end
