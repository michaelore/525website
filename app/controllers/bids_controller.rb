class BidsController < ApplicationController
  layout 'standard'
  # GET /bids
  # GET /bids.xml
  def index
    if session[:logged_in]
      @bids = Bid.find(:all)
      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @bids }
      end
    else
      redirect_to "/"
    end
  end

  # GET /bids/1
  # GET /bids/1.xml
  def show
    redirect_to "/" unless session[:logged_in]
    @bid = Bid.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @bid }
    end
  end

  # GET /bids/new
  # GET /bids/new.xml
  def new
    @bid = Bid.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @bid }
    end
  end

  # GET /bids/1/edit
  def edit
    redirect_to :action => "index" unless session[:logged_in]
    @admin = true
    @bid = Bid.find(params[:id])
  end

  # POST /bids
  # POST /bids.xml
  def create
    @bid = Bid.new(params[:bid])
    @last_bid = @bid.auction.bids[-1]

    respond_to do |format|
      if @bid.save
        flash[:notice] = 'Bid was successfully created.'
        format.html { redirect_to(@bid.auction) }
        format.xml  { render :xml => @bid, :status => :created, :location => @bid }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @bid.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /bids/1
  # PUT /bids/1.xml
  def update
    @bid = Bid.find(params[:id])
    @last_bid = @bid.auction.bids[-1]

    respond_to do |format|
      if @bid.update_attributes(params[:bid])
        flash[:notice] = 'Your bid has been submitted.'
        format.html { redirect_to(@bid) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @bid.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /bids/1
  # DELETE /bids/1.xml
  def destroy
    redirect_to :action => "index" unless session[:logged_in]
    @bid = Bid.find(params[:id])
    @bid.destroy

    respond_to do |format|
      format.html { redirect_to(bids_url) }
      format.xml  { head :ok }
    end
  end
end
