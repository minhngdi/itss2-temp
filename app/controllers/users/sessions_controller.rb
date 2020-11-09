class Users::SessionsController < Devise::SessionsController
  # GET /resource/sign_in
  def new
    self.resource = resource_class.new sign_in_params
    clean_up_passwords resource
    yield resource if block_given?
    respond_to do |format|
      format.html
      format.js
    end
  end
end