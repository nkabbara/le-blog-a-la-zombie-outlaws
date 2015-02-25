class WelcomeController < ApplicationController
  def index
    cms = Cms.new(version: 1.0, dir: '/usr/home/')
    render(text: 'Oh no!!!') unless cms.valid?
  end
end
