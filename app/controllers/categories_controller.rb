class CategoriesController < ApplicationController

  before_action :require_admin, :only => [:new, :create, :edit, :update]

  def index
    @categories = Category.paginate(:page => params[:page], per_page: 5)
  end

  def show
    @category = Category.find(params[:id])
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(categories_param)

    if @category.save
      flash[:success] = "Category has been created successfully"
      redirect_to categories_path
    else
      render :new
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])

    if @category.update(categories_param)
      flash[:success] = "Category has been updated successfully"
      redirect_to category_path(@category)
    else
      render :edit
    end
  end

  private
  def categories_param
    params.require(:category).permit(:name)
  end

  def require_admin
    if !logged_in? || !current_user.admin?
      flash[:danger] = "You must be logged in with an admin account to create categories"
      redirect_to root_path
    end
  end
end
