class Photos < ActiveRecord::Migration
    def self.up
        drop_table :photos

        create_table :photos do |t|
            t.column :title, :string, :limit => 60, :null => false
            t.column :image, :string, :limit => 60, :null => false
            t.column :description, :text
            t.column :category_id, :integer
            t.timestamps
        end
    end

    def self.down
        drop_table :photos
    end
end
