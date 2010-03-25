class CreateBids < ActiveRecord::Migration
  def self.up
    create_table :bids do |t|
      t.string :name, :limit => 60, :null => false
      t.string :contact, :limit => 100, :null => false
      t.integer :amount
      t.integer :auction_id
      t.timestamps
    end
  end

  def self.down
    drop_table :bids
  end
end
