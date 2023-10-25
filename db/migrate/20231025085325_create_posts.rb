class CreatePosts < ActiveRecord::Migration[7.1]
  def change
    create_table :posts do |t|
      t.integer :author_id
      t.string :title
      t.text :text
      t.datetime :created_at
      t.datetime :updated_at
      t.integer :comments_counter, default: 0
      t.integer :likes_counter, default: 0
    end
  end
end
