class PhotosController < ApplicationController
    layout 'standard'
    def index
        redirect_to :controller => 'categories'
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
    end

    def edit
	redirect_to :action => "index" unless session[:logged_in]
	@photo = Photo.find(params[:id])
    end

    def create
	@photo = Photo.new(params[:photo])
	file = @photo.image
	@photo.image = file.original_filename

	respond_to do |format|
	    if @photo.save
		Photo.add_files_for(file, Category.find(@photo.category_id).title)
		flash[:notice] = 'Photo was successfully created.'
		format.html { redirect_to(@photo) }
		format.xml  { render :xml => @photo, :status => :created, :location => @photo }
	    else
		format.html { render :action => "new", :category => @photo.category_id  }
		format.xml  { render :xml => @photo.errors, :status => :unprocessable_entity }
	    end
	end
    end

    def update
        @photo = Photo.find(params[:id])

        respond_to do |format|
            if @photo.update_attributes(params[:photo])
                flash[:notice] = 'Photo was successfully updated.'
                format.html { redirect_to @photo }
                format.xml { head :ok }
            else
                format.html { render :action => "edit" }
                format.xml { render :xml => @photo.errors, :status => :unprocessable_entity }
            end
        end
    end

    def destroy
        @photo = Photo.find(params[:id])
        Photo.remove_files_for(@photo.image, Category.find(@photo.category_id).title)
        @photo.delete

        respond_to do |format|
            format.html { redirect_to(photos_url) }
            format.xml { head :ok }
        end
    end
end

