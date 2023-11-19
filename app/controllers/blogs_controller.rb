class BlogsController < ApplicationController
    before_action :authorize_request

    def create 
        blog = current_user.blog_contents.create blog_params
        render json: {message: :blog_created, blog: blog}
    end

    private 

    def blog_params 
        params.permit(:title, :body)
    end
end
