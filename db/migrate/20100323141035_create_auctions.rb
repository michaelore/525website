class CreateAuctions < ActiveRecord::Migration
  def self.up
    create_table :auctions do |t|
      t.column :title, :string, :limit => 60, :null => false
      t.column :photo, :string, :limit => 60, :null => false
      t.column :description, :text
      t.column :initial_bid, :integer #Pennies, not dollars
      t.timestamps
    end
  end

  def self.down
    drop_table :auctions
  end
end
