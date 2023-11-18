class BlogContent < ApplicationRecord
    belongs_to :user

    validates :user_id, :title, :body, presence: true
end
