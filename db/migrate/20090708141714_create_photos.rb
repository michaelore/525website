class CreatePhotos < ActiveRecord::Migration
    def self.up
        create_table :photos do |t|
            t.column :title, :string, :limit => 60, :null => false
            t.column :image, :string, :limit => 60, :null => false
            t.column :description, :text
            t.timestamps
        end
    end

    def self.down
        drop_table :photos
    end
end
