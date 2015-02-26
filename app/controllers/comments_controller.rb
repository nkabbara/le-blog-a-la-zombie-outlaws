class CommentsController < ApplicationController
  #http_basic_authenticate_with name: 'nash', password: 'mypass123', only: :destroy
  # Will not have repsonse body, obviously.
  before_action :log_me, only: :create
  # Will have a repsonse body, obviously.
  after_action :log_me, only: :create
  around_action :around_me, only: :create
  
  def create
    session[:who] = 'Nash'
    article = params[:article_id] ? Article.find(params[:article_id]) : AboutMe.first
    article.comments.create(comment_params)

    redirect_to(params[:article_id] ? article_path(article) : about_me_path, notice: "Created!")
  end

  def destroy
    commentable = params[:article_id] ? Article.find(params[:article_id]) : AboutMe.first
    comment = commentable.comments.find(params[:id])
    comment.destroy

    redirect_to params[:article_id] ? article_path(commentable) : about_me_path
  end

  private
  def comment_params
    params.require(:comment).permit(:commenter, :body)
  end

  def log_me
    logger.info("LOG LOG LOG: I'm logged! #{response.body}")
  end

  def around_me
    logger.info("LOG AROUND LOG (Before Yield): I'm AROUND logged! #{response.body}")
    yield #Rails passes controller & view rendering to the block
    logger.info("LOG AROUND LOG (After Yield): I'm AROUND logged! #{response.body}")
  end
end
