class Commentable
  def self.call(mapper, options)
    mapper.resources :comments, options
  end
end
