class CommentsController < ApplicationController
  #http_basic_authenticate_with name: 'nash', password: 'mypass123', only: :destroy
  
  def create
    article = params[:article_id] ? Article.find(params[:article_id]) : AboutMe.first
    article.comments.create(comment_params)

    redirect_to params[:article_id] ? article_path(article) : about_me_path
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
end
