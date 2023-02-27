class CommentsController < ApplicationController
  before_action :login_required
  # before_action :authenticate_user!
  before_action :set_post, only: %i[ create edit update ]
  before_action :own_comment, only: %i[ edit update destroy ]


  def create
    @comment = @post.comments.build(comment_params)
    @comment.user_id = current_user.id
    respond_to do |format|
      if @comment.save
        format.js { render :index }
      else
        format.html { redirect_to post_path(@post), notice: '投稿できませんでした' }
      end
    end
  end

  def edit
    @comment = @post.comments.find(params[:id])
    respond_to do |format|
      flash.now[:notice] = 'コメントの編集中'
      format.js { render :edit }
    end
  end

  def update
    @comment = @post.comments.find(params[:id])
    respond_to do |format|
      if @comment.update(comment_params)
        flash.now[:notice] = 'コメントが編集されました'
        format.js { render :index }
      else
        flash.now[:notice] = 'コメントの編集に失敗しました'
        format.js { render :edit }
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    respond_to do |format|
      flash.now[:notice] = 'コメントが削除されました'
      format.js { render :index }
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def set_post
    @post = Post.find(params[:post_id])
  end

  def own_comment
    @comment = Comment.find(params[:id])
    unless current_user == Comment.find(params[:id]).user
      redirect_to posts_path, notice: '他人のコメントは編集・削除できません'
    end
  end

  def login_required
    redirect_to new_user_session_path, alert: 'ログインしてください' unless current_user
  end
end