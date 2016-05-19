class ArticlesController < ApplicationController

  # The set article method will always be called before actions edit, update, show and destroy.
  before_action :set_article, only: [:edit, :update, :show, :destroy]

  def index
    @articles = Article.paginate(:page => params[:page], :per_page => 5)
  end

  def show
  end

  def new
    @article = Article.new
  end

  def edit
  end

  def create
    #   render plain: params[:article].inspect
    @article = Article.new(article_params)
    # Workaround to create articles while the user log in feature is not ready
    @article.user = User.find(11)
    if @article.save
      # The hash flash will only store the message for next request. After that it'll be cleared
      flash[:success] = "Article has been saved successfully"
      redirect_to article_path(@article)
    else
      render :new
    end
  end

  def update
    if @article.update(article_params)
      flash[:success] = "Article has been edited successfully"
      redirect_to article_path(@article)
    else
      render :edit
    end
  end

  def destroy
    @article.destroy
    flash[:danger] = "Article has been deleted"
    redirect_to articles_path
  end

  private
    def article_params
      params.require(:article).permit(:title, :description)
    end

    def set_article
      @article = Article.find(params[:id])
    end
end
