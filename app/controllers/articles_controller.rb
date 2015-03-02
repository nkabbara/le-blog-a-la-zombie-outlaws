class ArticlesController < ApplicationController
  include ActionController::Live
  #http_basic_authenticate_with name: 'nash', password: 'mypass123', except: [:index, :show]
  # Muwahahahaha no etags for you! Unless you refresh in under one sec
  etag { Time.now }

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
    respond_to do |format|
      format.html
      format.json
    end
  end

  def stream
    response.headers['Content-Type'] = 'text/event-stream'
    redis = Redis.new
    redis.subscribe('mychannel') do |on|
      on.message do |event, data|
        response.stream.write("event: message\n")
        response.stream.write("data: #{data}\n\n")
      end
    end
    render nothing: true
    
  rescue IOError
    logger.info "Stream closed"
  ensure
    redis.quit
    response.stream.close 
  end

  def index
    @articles = Article.all
    fresh_when(@articles.last)
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
