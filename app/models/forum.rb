class Forum < ActiveRecord::Base
  validates :name, presence: true
  has_many  :topics, :dependent => :destroy
  Will work to implement later.
end
