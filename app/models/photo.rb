class Photo < ActiveRecord::Base
    include Magick
    validates_presence_of :title, :image, :category_id
    validates_uniqueness_of :image
    belongs_to :category
    def Photo.add_files_for(file, category)
	name = file.original_filename
        directory = File.join('public', 'images', category)
        path = File.join(directory, name)
        File.open(path, "wb") { |f| f.write(file.read) } unless File.exists?(path)
        thumb = Image.read(path).first.thumbnail(70, 70)
        thumb_path = File.join(directory, 'thumb', name)
        thumb.write(thumb_path) unless File.exists?(thumb_path)
    end
    def Photo.remove_files_for(name, category)
        directory = File.join('public', 'images', category)
        path = File.join(directory, name)
        File.delete(path)
        thumb_path = File.join(directory, 'thumb', name)
        File.delete(thumb_path)
    end
end
