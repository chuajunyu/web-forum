class CreatePosts < ActiveRecord::Migration[7.1]
  def change
    create_table :posts do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.string :title
      t.text :content
      t.integer :vote
      t.integer :supervote

      t.timestamps
    end
  end
end
