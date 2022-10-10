class ApplicationController < ActionController::API
    attr_accessor :current_user
    before_action :authenticate_user
    
    def authenticate_user
        puts "Authenticate - authenticate user..."
        # get auth token from header
        @request_token = request.headers["X-Auth-Token"]

        p "current_user - " 
        p current_user
        # compare with auth token from user
        # if logged_in? && current_user.auth_token == request_token && current_user.auth_token_created_at + AUTH_TOKEN_VALIDITY > (Time.now) 
        if current_user && current_user.valid_token?
            puts "Token matches. User authorized" 
            return true
        else
            puts "Auth token not valid" 
            render  json: { error: 'Authentication token is invalid' }, 
                    status: :unauthorized
        end
    end

    def logged_in?
        # !!session[:user_id]
    end

    def current_user
        @current_user ||= User.find_by_auth_token(@request_token) if @request_token
        # @current_user ||= User.find_by_id(session[:user_id]) if !!session[:user_id]
    end
end