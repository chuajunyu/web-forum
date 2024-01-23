class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :name
      t.integer :supervote
      t.datetime :lastseen

      t.timestamps
    end
    add_index :users, :name, unique: true
  end
end
