class Photo < ActiveRecord::Base
    validates_presence_of :title, :image, :category_id
    belongs_to :category
    def self.save(image)
        name = image['photo'].original_filename
        directory = 'public/images/data'
        path = File.join(directory, name)
        File.open(path, "wb") { |f| f.write(upload['photo'].read) }
    end
end
