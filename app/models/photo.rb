class Photo < ActiveRecord::Base
    validates_presence_of :title, :image
    belongs_to :category
end
