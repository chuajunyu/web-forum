class PostsController < ApplicationController
  before_action :set_post, only: %i[ show update destroy ]

  # GET /posts
  def index
    @posts = Post.all

    render json: @posts
  end

  # GET /posts/1
  def show
    render json: @post
  end

  # GET /postsbyuser
  def show_by_user
    @user = User.find(params[:id])
    render json: @user.posts
  end

  # POST /posts
  def create
    @post = Post.new(post_params)
    @post.vote = 0
    @post.supervote = 0

    if @post.save
      render json: @post, status: :created, location: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /posts/1
  def update
    if @post.update(update_post_params)
      render json: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # DELETE /posts/1
  def destroy
    @post.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:user_id, :title, :content, :vote, :supervote)
    end

    # Only allows content to be updated
    def update_post_params
      params.require(:post).permit(:content)
    end
end
