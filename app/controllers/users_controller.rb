class UsersController < ApplicationController
  wrap_parameters :user, include: [:name, :password]
  skip_before_action :authorized, only: [:create]
  rescue_from ActiveRecord::RecordInvalid, with: :handle_invalid_record
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

  # GET /usersbyname
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
    user = User.create!(user_params)
    # @user = User.new(user_params)
    user.supervote = 5
    user.lastseen = DateTime.current()
    @token = encode_token(user_id: user.id)
    render json: {
        user: UserSerializer.new(user), 
        token: @token
    }, status: :created
  end

  # PATCH/PUT /users/1
  def update
    # Updates the amount of supervotes that a user has
    @user.lastseen ||= DateTime.current() # Set @user.lastseen to the current date and time if it's nil
    
    # User last seen more than 24 hours ago
    if (DateTime.current() - @user.lastseen.to_datetime) > 0.01  # TODO: Change this to 24 hours when done testing
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

    # Only allow name through
    def user_params
      params.require(:user).permit(:name, :password)
    end

    def handle_invalid_record(e)
      render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
    end
end
