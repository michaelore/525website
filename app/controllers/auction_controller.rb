class AuctionController < ApplicationController
    layout 'standard'
    def index
	@auction = Auction.find(:all)
	
	respond_to do |format|
            format.html
        end
    end

    def show
        @auction = Auction.find(params[:id])
	@bids = @auction.bids

        respond_to do |format|
            format.html
            format.xml {render :xml => @bids}
        end
    end

    def new
        redirect_to :action => "index" unless session[:logged_in]
        @auction = Auction.new
    end

    def edit
        redirect_to :action => "index" unless session[:logged_in]
        @auction = Auction.find(params[:id])
    end

    def create
        @auction = Auction.new(params[:auction])

        respond_to do |format|
            if @auction.save
                flash[:notice] = 'Auction was successfully created.'
                format.html { redirect_to(@auction) }
                format.xml  { render :xml => @auction, :status => :created, :location => @auction }
            else
                format.html { render :action => "new" }
                format.xml  { render :xml => @auction.errors, :status => :unprocessable_entity }
            end
        end
    end

    def update
        @auction = Auction.find(params[:id])

        respond_to do |format|
            if @auction.update_attributes(params[:auction])
                flash[:notice] = 'Auction was successfully updated.'
                format.html { redirect_to(@auction) }
                format.xml  { head :ok }
            else
                format.html { render :action => "edit" }
                format.xml  { render :xml => @auction.errors, :status => :unprocessable_entity }
            end
        end
    end

    def destroy
        @auction = Auction.find(params[:id])
	@auction.bids.each {|x| x.destroy}
        @auction.destroy

        respond_to do |format|
            format.html { redirect_to(posts_url) }
            format.xml  { head :ok }
        end
    end
end
