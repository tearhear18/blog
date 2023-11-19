class BlogContent < ApplicationRecord
    include SearchCop
    
    belongs_to :user

    search_scope :search do
        attributes :title, :body
    end

    validates :user_id, :title, :body, presence: true
end
