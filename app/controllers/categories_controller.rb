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

        respond_to do |format|
            format.html
            format.xml {render :xml => @category}
        end
    end

    def edit
        redirect_to :action => "index" unless session[:logged_in]
        @category = Category.find(params[:id])
    end

    def create
        @category = Category.new(params[:category])

        respond_to do |format|
            if @category.save
                flash[:notice] = 'Photo was successfully created.'
                format.html { redirect_to(@category) }
                format.xml  { render :xml => @category, :status => :created, :location => @category }
            else
                format.html { render :action => "new" }
                format.xml  { render :xml => @category.errors, :status => :unprocessable_entity }
            end
        end
    end
end