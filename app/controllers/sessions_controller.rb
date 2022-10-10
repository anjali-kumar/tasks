class SessionsController < ApplicationController
    skip_before_action :authenticate_user, only: %i[ create]

    #login
    def create
        @user = User.find_by(username: login_params[:username])

        if @user && @user.authenticate(login_params[:password])
            puts '#login - user authenticated!'
            # @user.update_auth_token
            @user.auth_token_created_at = Time.now
            @user.regenerate_auth_token

            response.set_header('X-Auth-Token', @user.auth_token)
            render  json: { message: "Logged in successfuly" ,  user: @user.as_json(only: [:id, :username, :auth_token])}, 
                    status: :ok
        else
            render  json: { error: 'username or password is incorrect' }, 
                    status: :unauthorized
        end
    end

    def destroy
    end

    private
    # Only allow a list of trusted parameters through.
    def login_params
      params.require(:user).permit(:username, :password)
    end
end
