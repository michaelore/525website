class Bid < ActiveRecord::Base
    validates_presence_of :amount, :name, :phone, :address, :auction_id
    validate :must_be_in_range
    def must_be_in_range
	last_bid = if @auction.bids[-1] then @auction.bids[-1].amount else @auction.initial_bid end
	unless last_bid < amount
	    errors.add_to_base("Your bid must be greater than the previous bid.")
	end
    end
    belongs_to :auction
end
