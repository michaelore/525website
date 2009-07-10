class Photo < ActiveRecord::Base
    validates_presence_of :title, :image, :category_id
    belongs_to :category
end
