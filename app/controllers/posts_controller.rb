class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update]

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    respond_to do |format|
      format.html { render :show }
      format.json { render json: @post}
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.create(post_params)
    #redirect_to post_path(@post)
    #201 means that the resource was created
    render json: @post, status: 201

  end

  def edit
  end

  def update
    @post.update(post_params)
    redirect_to post_path(@post)
  end

  def post_data
    post = Post.find(params[:id])
    #render json: PostSerializer.serialize(post)
    render json: post.to_json(only: [:title, :description, :id],
                              include: [author: { only: [:name]}])
  end

private
  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def post_params
    params.require(:post).permit(:title, :description)
  end
end
