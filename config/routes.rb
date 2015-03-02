Rails.application.routes.draw do
  # Zombie Outlaws Lesson One
  # I'm commenting the resource below which will basically force me to unpack the routes one by one.

  # Concern has to be placed above code that uses it.
  #concern :commentable do
    #resources :comments
  #end

  get 'articles/stream', to: 'articles#stream'
  get 'articles/todays', to: 'articles#todays', as: :todays_articles
  get 'articles/with_comments_by/:id', to: 'articles#by', as: :articles_with_comments_by
  get 'articles/with_title', to: 'articles#with_title', as: :articles_with_title
  concern :commentable, Commentable
  #resources :articles, concerns: :commentable
  resources :articles do
    concerns :commentable, only: [:create, :destroy]
  end


  # Remember, a singular resource doesn't have #index. Calling link_to "Bla bla", controller: 'about_me' will err out. Also note, that controller is AboutMes (plural) because rails is optimizing for cases where you'd want to map plural resources.
  resource :about_me , concerns: :commentable


  root 'welcome#index', as: 'home'

  # Watch rails blow up for using match! XSS no mo'!
  #match 'articles', to: 'acticles#index'
  

  # We should use verbs instead or via: (verb)
  #get 'articles', to: 'articles#index'

  # When we put "as: 'xxx_article'", url helpers are created to map to that route. Otherwise, rails will have to deduce them from the url pattern which doesn't make sense for some patterns.
  #get 'articles/new', to: 'articles#new', as: 'new_article'
  #get 'articles/:id', to: 'articles#show', as: 'article'
  #get 'articles/:id/edit', to: 'articles#edit', as: 'edit_article'
  #patch 'articles/:id', to: 'articles#update'
  #delete 'articles/:id', to: 'articles#destroy'
  #post 'articles', to: 'articles#create'
  
  # This doesn't work here because routes are prioritized based on precendent. Rails will think that new is :id. Put it on top of its corresponding routes.
  #get 'articles/new', to: 'articles#new', as: 'new_article'

  #post 'articles/:article_id/comments', to: 'comments#create', as: 'article_comments'
  #delete 'articles/:article_id/comments/:id', to: 'comments#destroy', as: 'article_comment'
end
