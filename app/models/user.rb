class User < ApplicationRecord
    has_many :blog_contents
    has_many :auth_tokens
    has_secure_password
    
	validates :username, :password, presence: true
    validates :username, uniqueness: true
    validates :username,length: {minimum: 6, maximum: 20 }
    validates :password,length: {minimum: 6, maximum: 50 }

    def generate_access_token
		token = Digest::SHA1.hexdigest("#{id}_#{Time.current.to_s}")
        auth_tokens.create token: token
	end	
end
