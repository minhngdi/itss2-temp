class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create, :update]
  def new
    @user = User.new
    respond_to do |format|
      format.html
      format.js
    end
  end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
     devise_parameter_sanitizer.permit :sign_up, keys: [:name, :email,
       :password, :password_confirmation, :avatar, :avatar_cache]
       devise_parameter_sanitizer.permit :account_update, keys: [:name, :email,
        :password, :password_confirmation, :avatar, :avatar_cache]
  end
  def update_resource(resource, params)
    resource.update_without_password(params)
  end
  def after_update_path_for(resource)
     user_path(resource)
   end
end
