class Topic < ActiveRecord::Base
  validates  :name, presence: true
  validates  :content, presence: true
  belongs_to :forum
  has_many   :posts, :dependent => :destroy
end
