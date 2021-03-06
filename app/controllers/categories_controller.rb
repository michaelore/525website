class CategoriesController < ApplicationController
    layout 'standard'
    def index
        @categories = Category.find(:all)

        respond_to do |format|
            format.html
        end
    end

    def show
        @category = Category.find(params[:id])
        @photos = @category.photos

        respond_to do |format|
            format.html
            format.xml {render :xml => @photos}
        end
    end

    def new
        redirect_to :action => "index" unless session[:logged_in]
        @category = Category.new
    end

    def edit
        redirect_to :action => "index" unless session[:logged_in]
        @category = Category.find(params[:id])
    end

    def create
        @category = Category.new(params[:category])

        respond_to do |format|
            if @category.save
                @category.add_folder_for
                flash[:notice] = 'Photo was successfully created.'
                format.html { redirect_to(@category) }
                format.xml  { render :xml => @category, :status => :created, :location => @category }
            else
                format.html { render :action => "new" }
                format.xml  { render :xml => @category.errors, :status => :unprocessable_entity }
            end
        end
    end

    def update
        @category = Category.find(params[:id])
	old_folder = @category.title

        respond_to do |format|
            if @category.update_attributes(params[:category])
		@category.update_folder_from(old_folder)
                flash[:notice] = 'Post was successfully updated.'
                format.html { redirect_to(@category) }
                format.xml  { head :ok }
            else
                format.html { render :action => "edit" }
                format.xml  { render :xml => @category.errors, :status => :unprocessable_entity }
            end
        end
    end

    def destroy
        @category = Category.find(params[:id])
	Photo.find(:all, :conditions => {:category_id => params[:id]}).each {|x| x.destroy}
        @category.remove_folder_for
        @category.destroy

        respond_to do |format|
            format.html { redirect_to(posts_url) }
            format.xml  { head :ok }
        end
    end
end
