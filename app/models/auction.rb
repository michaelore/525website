class Auction < ActiveRecord::Base
    validates_presence_of :title, :initial_bid, :description, :photo
    validates_uniqueness_of :title, :photo
    has_many :bids
end
