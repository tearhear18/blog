class ApplicationController < ActionController::API
	include ActionController::HttpAuthentication::Token::ControllerMethods
	include Pundit::Authorization

    attr_reader :current_user
    
    rescue_from ::UserError, with: :user_error_occured
	rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
	
    def authorize_request
		authenticate_with_http_token do |token, _options|
			token = AuthToken.find_by_token(token)
			raise UserError.new(:unauthorized, :unauthorized) if token.nil? || token.expired?
			@current_user = token.user
		end
	end

    private 
    
	def user_error_occured(exception)
		render json: {message: exception.message}, status: exception.code
	end

	def user_not_authorized
		render json: {message: "Unauthorized Accesss"}, status: :unauthorized
	end
end
