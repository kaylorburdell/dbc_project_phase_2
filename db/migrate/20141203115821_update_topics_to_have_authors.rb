  class UpdateTopicsToHaveAuthors < ActiveRecord::Migration
  def up
    add_column :topics, :user_id, :integer

    Topic.where(user_id: nil).each do |topic|
      topic.user = User.all.sample
      topic.save
    end
  end

end
