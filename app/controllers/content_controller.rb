class ContentController < ApplicationController
  layout 'standard'
  # GET /posts
  # GET /posts.xml
  def index
      redirect_to "/"
  end

  # GET /posts/1
  # GET /posts/1.xml
  def show
      render :file => params[:path].join("/")
  end
end
