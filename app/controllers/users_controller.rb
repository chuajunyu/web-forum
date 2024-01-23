class UsersController < ApplicationController
  before_action :set_user, only: %i[ show update destroy ]

  # GET /users
  def index
    @users = User.all

    render json: @users
  end

  # GET /users/1
  def show
      render json: @user
  end

  # GET /users/name
  def show_by_name
    @user = User.find_by(name: params[:name])
    if @user
      render json: @user
    else
      render json: { status: 404, error: "Not Found" }, status: :not_found
    end
  end

  # POST /users
  def create
    @user = User.new(user_params)
    @user.supervote = 5
    @user.lastseen = DateTime.current()

    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    @user.lastseen ||= DateTime.current() # Set @user.lastseen to the current date and time if it's nil
    if (DateTime.current() - @user.lastseen.to_datetime) > 0.01
      # User last seen more than 24 hours ago
      @user.supervote += 1
      @user.lastseen = DateTime.current()
      @user.save
      render json: { message: 'Supervote added' }
    end
  end

  def check_lastseen
    
  end

  # DELETE /users/1
  def destroy
    @user.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name, :supervote, :lastseen)
    end
end
