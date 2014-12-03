class CreateTopics < ActiveRecord::Migration
  def change
    create_table   :topics do |t|
      t.string     :name
      t.text       :content
      t.references :user
      t.references :forum
      t.timestamps
    end
  end
end
