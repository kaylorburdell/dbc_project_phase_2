  class UpdateTopicsToHaveAuthors < ActiveRecord::Migration
  def up
    remove_column :topics, :user_id
    add_column    :topics, :user_id, :integer

    Topic.where(user_id: nil).each do |topic|
      topic.user = User.all.sample
      topic.save
    end
  end

end
