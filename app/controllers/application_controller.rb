class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # The methods in ApplicationController are available to all controllers, but not to our views. So adding
  # the helper_method will tell rails that these methods should be available in the views as well.
  helper_method :current_user, :logged_in?

  def current_user
      # If there's a @current_user, just return it, else find the user if there's a user_id in the session
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
      # if @current_user
      #   @current_user
      # else
      #   if session[:user_id]
      #     @current_user = User.find(session[:user_id])
      #   end
      # end
  end

  def logged_in?
    # Returns true if there's a current user, and false otherwise
    # !!current_user
    current_user ? true : false
  end

  def require_user
    if !logged_in?
      flash[:danger] = "You must be logged in to perform this action."
      redirect_to(root_path)
    end
  end
end
