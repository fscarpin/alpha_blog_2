class SessionsController < ApplicationController
  def new

  end

  # Login: Create a new session
  def create
    # Find the user
    user = User.find_by(email: params[:session][:email].downcase)
    # Get the password from the parameters
    password = params[:session][:password]
    # Try to authenticate the user
    if user && user.authenticate(password)
      flash[:success] = "Welcome back #{user.username}"
      # Store the user id in the session
      session[:user_id] = user.id
      # Redirect the user to its page
      redirect_to user_path(user)
    else
      # Since we are using render, there won't be another request, so we need to use flash.now
      flash.now[:danger] = "Wrong email or password. Please try again."
      render :new
    end
  end

  # Logout: destroy the session
  def destroy
    # Remove the user_id from the session, and show a message
    session[:user_id] = nil
    flash[:success] = "You've been successfully logged out"
    redirect_to root_path
  end
end
