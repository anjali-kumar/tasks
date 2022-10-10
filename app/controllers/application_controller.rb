class ApplicationController < ActionController::API
    attr_accessor :current_user
    before_action :authenticate_user

    AUTH_TOKEN_VALIDITY = 1.minute
    
#   @@current_user = nil

    def authenticate_user
        puts "Authenticate - authenticate user..."
        # get auth token from header
        request_token = request.headers["X-Auth-Token"]

        # compare with auth token from user
        if logged_in? && current_user.auth_token == request_token && current_user.auth_token_created_at + AUTH_TOKEN_VALIDITY > (Time.now) 
            # puts "Token matches. User authorized" 
            return true
        else
            # puts "Auth token not valid" 
            render  json: { error: 'Authentication token is invalid' }, 
                    status: :unauthorized
        end
    end

    def logged_in?
        !!session[:user_id]
    end

    def current_user
        @current_user ||= User.find_by_id(session[:user_id]) if !!session[:user_id]
    end

    # def set_current_user(user)
    #     @@current_user = user
    # end

    # def get_current_user
    #     @@current_user
    # end
end