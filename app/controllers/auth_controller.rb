class AuthController < ApplicationController
    skip_before_action :authorized, only: [:login]
    rescue_from ActiveRecord::RecordNotFound, with: :handle_record_not_found

    def login 
        @user = User.find_by!(name: login_params[:name])

        if @user.authenticate(login_params[:password])
            @token = encode_token(user_id: @user.id)
            render json: {
                success: true,
                user: UserSerializer.new(@user),
                token: @token
            }, status: :accepted
        else
            render json: { success: false, message: 'Incorrect password'}, status: :unauthorized
        end

    end

    private 

    def login_params 
        params.permit(:name, :password)
    end

    def handle_record_not_found(e)
        render json: { success: false, message: "User doesn't exist" }, status: :unauthorized
    end
end