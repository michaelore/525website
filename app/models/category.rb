class Category < ActiveRecord::Base
    validates_presence_of :title
    validates_uniqueness_of :title
    has_many :photos
    def add_folder_for
        FileUtils.mkdir_p(File.join('public', 'images', self.title))
        FileUtils.mkdir_p(File.join('public', 'images', self.title, 'thumb'))
    end
    def remove_folder_for
        FileUtils.rm_rf(File.join('public', 'images', self.title))
    end
    def update_folder_from(old)
	FileUtils.mv(File.join('public', 'images', old), File.join('public', 'images', self.title))
    end
end
