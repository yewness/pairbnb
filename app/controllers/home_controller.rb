class HomeController < ApplicationController
  def index
  	render partial: "home/index"
  end
end
