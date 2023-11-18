class AuthToken < ApplicationRecord
    belongs_to :user
    
    TOKEN_EXPIRE_AFTER = 1.hour
    
    before_commit :add_token_expiration

    def active?
        valid_at >= Time.current
    end

    def expired? 
        !active?
    end
    
    private

    def add_token_expiration 
        self.valid_at = Time.current + TOKEN_EXPIRE_AFTER
    end
end
