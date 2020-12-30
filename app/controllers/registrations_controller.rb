class RegistrationsController < Devise::RegistrationsController
    private
  
    def sign_up_params
      params.require(:user).permit(:firstname, :lastname, :username, :email, :password, :password_confirmation)
    end
  
    def update_user_params
      params.require(:user).permit(:firstname, :lastname, :name, :username, :email, :password, :password_confirmation, :current_password)
    end
  end