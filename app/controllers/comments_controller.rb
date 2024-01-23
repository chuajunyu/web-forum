class CommentsController < ApplicationController
  before_action :set_comment, only: %i[ show update destroy ]

  # GET /comments
  def index
    @comments = Comment.all

    render json: @comments
  end

  # GET /comments/1
  def show
    render json: @comment
  end

  # GET /commentsbypost
  def show_by_post
    @post = Post.find(params[:id])
    render json: @post.comments
  end

  # POST /comments
  def create
    @comment = Comment.new(comment_params)
    @comment.vote = 0
    @comment.supervote = 0

    if @comment.save
      render json: @comment, status: :created, location: @comment
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /comments/1
  def update
    if @comment.update(update_comment_params)
      render json: @comment
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /comments/1
  def destroy
    @comment.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Don't allow votes and supervotes as they are initialised as 0
    def comment_params
      params.require(:comment).permit(:user_id, :post_id, :content)
    end

    def update_comment_params
      params.require(:comment).permit(:content)
    end
end
