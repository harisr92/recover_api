class CreateStates < ActiveRecord::Migration[5.1]
  def change
    create_table :states do |t|
      t.integer :x
      t.integer :y
      t.integer :platue_id
      t.string :face

      t.timestamps
    end
  end
end
