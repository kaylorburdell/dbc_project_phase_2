class Post < ActiveRecord::Base
  belongs_to :parent, class_name: "Topic", foreign_key: :topic_id
  belongs_to :user
  # belongs_to :topic
  # belongs_to :parent, class_name: "Post", foreign_key: :parent_id
  # has_many   :children, class_name: "Post", foreign_key: :parent_id
  # NOT SURE IF I WANT TO HAVE POSTS TALK TO OTHER POSTS BECAUSE IT COULD GET HELLA CONVOLUTED WHATEVER
  has_many :points
  has_many :pointgivers, through: :points, class_name: "User", source: :user

  def point(user)
    if self.pointgivers.include?(user)
      return false
    else
      self.points.create(user: user)
      return true
    end
  end

  def score
    self.points.size
  end

end
