class ArticlesController < ApplicationController
  #http_basic_authenticate_with name: 'nash', password: 'mypass123', except: [:index, :show]

  def with_title
    @articles = Article.where.not(title: '')
  end

  def by
    @articles = Article.includes(:comments).where("comments.commenter = ?", params[:id]).references("comments")
  end

  def todays
    @articles = Article.todays
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to @article
    else
      render 'new'
    end
  end

  def show
    @commentable = @article = Article.find(params[:id])
  end

  def index
    @articles = Article.all
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    article = Article.find(params[:id])
    article.destroy
    redirect_to articles_path
  end

  private
  def article_params
    # When we submit a form with the commented line below, Rails will log Unpermitted parameter.
    #params.require(:article).permit(:title)
    params.require(:article).permit(:title, :text)
  end
end
