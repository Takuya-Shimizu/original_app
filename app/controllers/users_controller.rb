class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show]
  before_action :require_permission, only: [:show]

  def show
    @user = User.find(params[:id])
    @favorites = current_user.favorite_posts
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def require_permission
    if current_user != @user
      redirect_to posts_path, alert: "アクセス権限がありません"
    end
  end
end