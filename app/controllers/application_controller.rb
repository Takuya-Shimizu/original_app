class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include ApplicationHelper
  # before_action :login_required
  before_action :configure_permitted_parameters, if: :devise_controller?

  # rescue_from CanCan::AccessDenied do |_exception|
  #   redirect_to root_path, alert: '画面を閲覧する権限がありません'
  # end

  private

  def login_required
    redirect_to new_user_session_path, alert: 'ログインしてください' unless current_user
  end

  def logged_in
    redirect_to posts_path, alert: 'ログイン中は新規登録画面にはアクセスできません' if current_user
  end

  def admin_login_required
    unless current_user && current_user.admin?
      redirect_to posts_path, alert: '管理者権限がないユーザーは管理者画面にはアクセスできません'
    end
  end

  def set_user
    @user = current_user
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:admin])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:specialist])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:admin])
    devise_parameter_sanitizer.permit(:account_update, keys: [:specialist])
  end

  def after_update_path_for(resource)
    user_path(id: current_user.id)
  end

end
