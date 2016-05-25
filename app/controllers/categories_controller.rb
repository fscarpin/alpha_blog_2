class CategoriesController < ApplicationController

  def index
    @categories = Category.all
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

  def show
    @category = Category.find(params[:id])
  end

  private
    def categories_param
      params.require(:category).permit(:name)
    end
end
