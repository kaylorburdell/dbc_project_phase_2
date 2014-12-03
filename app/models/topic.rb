class Topic < ActiveRecord::Base
  validates  :name, presence: true, uniqueness: true
  validates  :content, presence: true, uniqueness: true
  belongs_to :forum
  belongs_to :user
  has_many   :posts, :dependent => :destroy
end
