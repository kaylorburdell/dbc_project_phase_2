class CreateForums < ActiveRecord::Migration
  def change
    t.string :name
    t.timestamps
  end
end
