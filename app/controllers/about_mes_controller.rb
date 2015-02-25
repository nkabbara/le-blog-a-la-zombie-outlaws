class AboutMesController < ApplicationController
  def show
    @commentable = @about_me = AboutMe.first
  end
end
