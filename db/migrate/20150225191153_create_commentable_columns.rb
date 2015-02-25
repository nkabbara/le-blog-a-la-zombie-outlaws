class CreateCommentableColumns < ActiveRecord::Migration
  def change
    add_reference :comments, :commentable, polymorphic: true, index: true
    remove_column :comments, :article_id
  end
end
