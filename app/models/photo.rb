class Photo < ActiveRecord::Base
    validates_presence_of :title, :image, :category_id
    belongs_to :category
    alias old_save save
    def save(photo)
        name = photo['image'].original_filename
        directory = 'public/images/data'
        path = File.join(directory, name)
        File.open(path, "wb") { |f| f.write(photo['image'].read) }
        photo['image'] = 'data/' + name
        new_photo = Photo.new(photo)
        new_photo.old_save
    end
end
