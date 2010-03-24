class Bid < ActiveRecord::Base
    validates_presence_of :amount, :name, :contact
    validate :must_be_in_range
    def must_be_in_range
	auction = Auction.find(@auction_id)
	last_bid = auction.bids[-1]
	unless last_bid.amount > @amount
	    errors.add_to_base("Your bid must be greater than the previous bid.")
	end
    end
    belongs_to :auction
end
