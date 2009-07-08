class PhotosController < ApplicationController
    def index
	@categories = Category.find(:all)

	respond_to do |format|
	    format.html
	end
    end

    def show
	@photo = Photo.find(params[:id])

	respond_to do |format|
	    format.html
	    format.xml {render :xml => @photos}
	end
    end

    def new
	redirect_to :action => "index" unless session[:logged_in]
	@photo = Photo.new

	respond_to do |format|
	    format.html
	    format.xml {render :xml => @photo
	end
    end

    def edit
	redirect_to :action => "index" unless session[:logged_in]
	@photo = Photo.find(params[:id])
    end

    def create
	@photo = Photo.new(params[:photo])

	respond_to do |format|
	    if @photo.save
		flash[:notice] = 'Photo was successfully created.'
		format.html { redirect_to(@photo) }
		format.xml  { render :xml => @photo, :status => :created, :location => @photo }
	    else
		format.html { render :action => "new" }
		format.xml  { render :xml => @photo.errors, :status => :unprocessable_entity }
	    end
	end

