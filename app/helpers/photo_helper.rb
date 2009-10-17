module PhotoHelper
  def display(photo)
      category = Category.find(photo.category_id).title
      return image_tag(File.join(category, photo.image))
    end
    def display_thumb(photo)
      category = Category.find(photo.category_id).title
      image = image_tag(File.join(category, 'thumb', photo.image))
      return link_to(image, photo)
    end
end
