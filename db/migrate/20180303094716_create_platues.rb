class CreatePlatues < ActiveRecord::Migration[5.1]
  def change
    create_table :platues do |t|
      t.integer :width
      t.integer :height
      t.string :ip_addr

      t.timestamps
    end
  end
end
