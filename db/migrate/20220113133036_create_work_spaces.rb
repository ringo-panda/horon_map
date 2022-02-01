class CreateWorkSpaces < ActiveRecord::Migration[6.1]
  def change
    create_table :work_spaces do |t|
      t.integer :user_id
      t.string :name
      t.integer :root_id
      t.timestamps
    end
  end
end
