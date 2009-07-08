class Category < ActiveRecord::Base
    validates_prescense_of :title
    has_many :photos
end
