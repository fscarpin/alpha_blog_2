class UsersController < ApplicationController

  # Set the @user before show, edit and update methods
  before_action :set_user, :only => [:show, :edit, :update]

  # User must be logged in to edit and update profiles
  before_action :require_user, :only => [:edit, :update]

  # Users can only update their own profile
  before_action :require_same_user, :only => [:edit, :update]

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

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to Alpha Blog, #{@user.username}"
      redirect_to articles_path
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

  private
    def user_params
      params.require(:user).permit(:username, :email, :password)
    end

    def set_user
      @user = User.find(params[:id])
    end

    def require_same_user
      if @user != current_user
        flash[:danger] = "You can only edit your own profile"
        redirect_to(user_path current_user)
      end
    end
end
