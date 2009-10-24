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
    def update_attributes_and_files(new_photo)
        # new_photo[:category_id] is actually the title of the category.
        if new_photo[:category_id] then
          new_category = Category.find(:first,
                                       :conditions => ['title = ?', new_photo[:category_id]])
          old_category = Category.find(self.category_id)

          if not new_category then
            return false
          end
          
          old_path = File.join('public', 'images', old_category.title, self.image)
          new_path = File.join('public', 'images', new_category.title, self.image)
          
          File.rename(old_path, new_path)
          
          old_thumb_path = File.join('public', 'images', old_category.title, 'thumb', self.image)
          new_thumb_path = File.join('public', 'images', new_category.title, 'thumb', self.image)

          File.rename(old_thumb_path, new_thumb_path)
          
          new_photo[:category_id] = new_category.id
        end
        self.update_attributes(new_photo)
    end
end
