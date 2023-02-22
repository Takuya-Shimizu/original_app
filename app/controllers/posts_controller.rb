class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, only: %i[ new edit update destroy ]
  before_action :own_post, only: %i[ edit update destroy ]

  def index
    @posts = Post.all
    @posts = Post.tagged_with(params[:label])
  end

  def show
    # @favorite = current_user.favorites.find_by(post_id: @post.id)
    @comments = @post.comments
    @comment = @post.comments.build
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def create
    @post = current_user.posts.build(post_params)
    respond_to do |format|
      if @post.save
        format.html { redirect_to post_url(@post), notice: "投稿しました" }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to post_url(@post), notice: "投稿を編集しました" }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url, notice: "投稿を削除しました" }
      format.json { head :no_content }
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content, { label_ids: [] })
  end

  def own_post
    @post = Post.find(params[:id])
    unless current_user == Post.find(params[:id]).user
      redirect_to posts_path, notice: '他人の投稿は編集・削除できません'
    end
  end
end