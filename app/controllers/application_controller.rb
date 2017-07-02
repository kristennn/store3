class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def admin_required
    if !current_user.is_admin
      redirect_to root_path, warning: "你没有权限"
    end
  end

end
