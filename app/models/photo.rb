class Photo < ActiveRecord::Base
    validates_prescense_of :title, :image
    belongs_to :category
end
