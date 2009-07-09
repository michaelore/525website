# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
    def display_thumb(photo)
        link_to (image_tag ("thumb_" + photo.image)), photo
    end
end
