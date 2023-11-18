class User < ApplicationRecord
    has_many :blog_contents

	validates :username, :password, presence: true
    validates :username, uniqueness: true
    validates :username,length: {minimum: 6, maximum: 20 }
    validates :password,length: {minimum: 6, maximum: 50 }
    
end
