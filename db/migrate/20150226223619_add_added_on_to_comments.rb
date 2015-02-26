class AddAddedOnToComments < ActiveRecord::Migration
  def change
    add_column :comments, :added_on, :date
  end
end
