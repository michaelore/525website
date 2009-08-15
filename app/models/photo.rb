class Photo < ActiveRecord::Base
    include Magick
    validates_presence_of :title, :image, :category_id
    validates_uniqueness_of :image
    belongs_to :category
    def self.add_files_for(photo)
        name = photo['image'].original_filename
        directory = 'public/images'
        path = File.join(directory, name)
        File.open(path, "wb") { |f| f.write(photo['image'].read) } unless File.exists?(path)
        thumb = Image.read(path).first.thumbnail(70, 70)
        thumb_path = File.join(directory, ("thumb_" + name))
        thumb.write(thumb_path) unless File.exists?(thumb_path)
    end
end
