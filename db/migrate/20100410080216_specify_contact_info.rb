class SpecifyContactInfo < ActiveRecord::Migration
  def self.up
    add_column "bids", "phone", :string, :limit => 200, :default => "", :null => false
    add_column "bids", "address", :string, :limit => 200, :default => "", :null => false
    remove_column "bids", "contact"
  end

  def self.down
    remove_column "bids", "phone"
    remove_column "bids", "address"
    add_column "bids", "contact", :string, :limit => 100, :null => false
  end
end
