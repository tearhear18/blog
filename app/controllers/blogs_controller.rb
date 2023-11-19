class BlogsController < ApplicationController
    before_action :authorize_request

    def search
        blogs = current_user.blog_contents.search params[:q]
        render json: {
            message: 'success',
            blogs: ActiveModel::Serializer::CollectionSerializer.new(
                blogs,
                serializer: BlogSerializer
            )
        }
    end

    def index 
        blogs = current_user.blog_contents
        render json: {
            message: 'success',
            blogs: ActiveModel::Serializer::CollectionSerializer.new(
                blogs,
                serializer: BlogSerializer
            )
        }
    end
    
    def create 
        blog = current_user.blog_contents.create blog_params
        render json: {
            message: :blog_created, 
            blog: BlogSerializer.new(
				blog
			),
        }
    end

    def show 
        blog = current_user.blog_contents.find_by_id(params[:id])
        render json: {
            message: :blog_created, 
            blog: BlogSerializer.new(
				blog
			),
        }
    end

    def update 
        blog = current_user.blog_contents.find_by_id(params[:id])
        blog.update blog_params
        render json: {
            message: :blog_updated, 
            blog: BlogSerializer.new(
				blog
			),
        }
    end

    def destroy 
        blog = current_user.blog_contents.find_by_id(params[:id])
        blog.destroy
        render json: {message: :blog_deleted}
    end

    private 

    def blog_params 
        params.permit(:title, :body)
    end
end
