class UsersController < ApplicationController

  # Set the @user before show, edit, update and destroy methods
  before_action :set_user, :only => [:show, :edit, :update, :destroy]

  # User must be logged in to edit, update and delete profiles
  before_action :require_user, :only => [:edit, :update, :destroy]

  # Users can only update their own profile or delete their own accounts
  before_action :require_same_user, :only => [:edit, :update, :destroy]

  # Only admins are allowed to delete users
  before_action :require_admin, :only => [:destroy]

  # Sign up form
  def new
    @user = User.new
  end

  def index
    # using the will_paginate gem instead of loading  all users using User.all
    @users = User.paginate(:page => params[:page], :per_page => 5)
  end

  def show
    @user_articles = @user.articles.paginate(:page => params[:page], :per_page => 5)
  end

  # Create a new user
  def create
    @user = User.new(user_params)

    return if !validate_signup_passwords

    if @user.save
      flash[:success] = "Welcome to Alpha Blog, #{@user.username}"
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] = "Your account has been updated successfully"
      redirect_to articles_path
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = "#{@user.username} account and articles has been deleted"
    end

    redirect_to users_path
  end

  private
    def user_params
      params.require(:user).permit(:username, :email, :password)
    end

    def set_user
      @user = User.find(params[:id])
    end

    def require_same_user
      if @user != current_user && !current_user.admin?
        flash[:danger] = "You can only edit your own profile"
        redirect_to(user_path current_user)
      end
    end

    def require_admin
      if !current_user.admin?
        flash[:danger] = "Only admin users can  perform this action"
        redirect_to users_path
      end
    end

    def validate_signup_passwords
      password = params[:user]["password"]
      confirm_password = params[:user]["confirm_your_password"]
      if password != confirm_password
        @user.errors.add(:password, "doesn't match. Make sure you specify the same password in both fields")
        render :new
        return false
      else
        return true
      end
    end
end
