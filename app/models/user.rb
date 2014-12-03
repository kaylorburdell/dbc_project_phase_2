class User < ActiveRecord::Base
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email,
            :presence => {:message => "Enter your email address!" },
            :format => {:with => VALID_EMAIL_REGEX, :message => "Enter a valid Email address !"},
            :uniqueness => {:case_sensitive => false, :message => "Email already exists!"}
  validates :alias,
            :presence => {:message => "Enter your desired alias!" },
            :uniqueness => {:case_sensitive => false, :message => "Alias already exists!"}
  validates :password, presence: true
  has_many  :posts
  has_many  :topics
  has_secure_password
end
