class CreatePosts < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.text        :content
      t.references  :user
      t.references  :topic
      t.timestamps
  end
end
