class CreateComments < ActiveRecord::Migration[7.1]
  def change
    create_table :comments do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :post, null: false, foreign_key: true
      t.text :content
      t.integer :vote
      t.integer :supervote

      t.timestamps
    end
  end
end
