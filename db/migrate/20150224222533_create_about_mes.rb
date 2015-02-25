class CreateAboutMes < ActiveRecord::Migration
  def change
    create_table :about_mes do |t|
      t.string :title
      t.text :text
    end
  end
end
