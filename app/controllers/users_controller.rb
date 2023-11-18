class UsersController < ApplicationController
    
    def login 
        user = User.find_by_username(user_params[:username])
        raise UserError.new("Invalid Account", :unauthorized) if user.nil?
        
        unless user.authenticate user_params[:password]
            raise UserError.new(:invalid_account, :unauthorized)
        end
        auth = user.generate_access_token
        render json: {message: :login_success, access_token: auth.token} 
    end
    
    def create 
        User.create! user_params
        render json: {message: :created}
    end

    private 

    def user_params 
        params.require(:user).permit(:username, :password)
    end
end
