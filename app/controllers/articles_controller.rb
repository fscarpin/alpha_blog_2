class ArticlesController < ApplicationController

  def new
    @article = Article.new
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      flash[:notice] = "Article has been edited successfully"
      redirect_to article_path(@article)
    else
      render :edit
    end
  end

  def create
    #   render plain: params[:article].inspect
    @article = Article.new(article_params)
    if @article.save
      flash[:notice] = "Article has been saved successfully"
      redirect_to article_path(@article)
    else
      render :new
    end
    # if @article.save
    #   # The hash flash will only store the message for next request. After that it'll be cleared
    #   flash[:notice] = "Article has been saved successfully"
    #   # redirect_to article_path(@article)
    #   render plain: "test"
    # else
    #         render :new
    # end
  end

  def show
    @article = Article.find(params[:id])
  end

  private
    def article_params
      params.require(:article).permit(:title, :description)
    end
end
