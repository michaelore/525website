class Photo < ActiveRecord::Base
    include Magick
    validates_presence_of :title, :image, :category_id
    validates_uniqueness_of :image
    belongs_to :category
    def add_files_for
        category = Category.find(self.category_id).title
        name = self.image.original_filename
        directory = File.join('public', 'images', category)
        path = File.join(directory, name)
        File.open(path, "wb") { |f| f.write(self.image.read) } unless File.exists?(path)
        thumb = Image.read(path).first.thumbnail(70, 70)
        thumb_path = File.join(directory, 'thumb', name)
        thumb.write(thumb_path) unless File.exists?(thumb_path)
    end
    def remove_files_for
        category = Category.find(self.category_id).title
        name = self.image
        directory = File.join('public', 'images', category)
        path = File.join(directory, name)
        File.delete(path)
        thumb_path = File.join(directory, 'thumb', name)
        File.delete(thumb_path)
    end
    def display
        category = Category.find(self.category_id).title
        return image_tag(File.join('public', 'images', category, self.image))
    end
    def display_thumb
        category = Category.find(self.category_id).title
        return image_tag(File.join('public', 'images', category, 'thumb', self.image))
    end
end
