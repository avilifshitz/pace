class RegistrationsController < Devise::RegistrationsController
layout :check_layout
  # GET /resource/sign_up
  def new
    build_resource({})
    respond_with self.resource
  end

  # POST /resource
  def create
    build_resource(sign_up_params)
    if resource.save
      yield resource if block_given?
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_flashing_format?
        sign_up(resource_name, resource)
        respond_with resource, :location => after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
        expire_data_after_sign_in!
        respond_with resource, :location => after_inactive_sign_up_path_for(resource)
      end
      session[:goal_title]=nil
      session[:goal_to]=nil
      session[:goal_from]=nil
      session[:miles_title]=nil
      session[:miles_to]=nil
      session[:miles_from]=nil
      
    else
      clean_up_passwords resource
      respond_with resource
    end

  end

  def sign_up_params
    params.require(:user).permit(:email,:password,:password_confirmation,:is_goaler,:goal_title,:goal_from,:goal_to,:miles_title,:miles_from,:miles_to)
  end
  
  def check_layout

    
      
    if !current_user.blank?  && current_user.is_admin?  
      'admin'
    else
      'theme'
    end
   
  end
  
end