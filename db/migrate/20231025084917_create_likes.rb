class CreateLikes < ActiveRecord::Migration[7.1]
  def change
    create_table :likes do |t|
      t.references :user, foreign_key: true, index: true
      t.references :post, foreign_key: true, index: true
      t.datetime :updated_at
      t.datetime :created_at
    end
  end
end
