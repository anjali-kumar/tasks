class SessionsController < ApplicationController

    def create
        puts params[:username]
        puts params[:password]
        @user = User.find_by(username: params[:username])
        puts @user
        if @user && @user.authenticate(params[:password])
            puts 'authenticated!'
        else
            puts 'username or password is incorrect'
        end
    end

    def destroy
    end
end
