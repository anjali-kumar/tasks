class SessionsController < ApplicationController
    #login
    def create
        data = login_params
        @user = User.find_by(username: data[:username])

        if @user && @user.authenticate(data[:password])
            # puts 'authenticated!'
            @user.regenerate_auth_token
            @user.auth_token_created_at = Time.now
            @user.save
            response.set_header('auth_token', @user.auth_token)
            render  json: @user.as_json(only: [:id, :username]), 
                    status: :ok
        else
            puts 'username or password is incorrect'
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
