class Forum < ActiveRecord::Base
  validates :name, presence: true
  has_many  :topics, :dependent => :destroy
end
