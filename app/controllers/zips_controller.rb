require 'zip/zip'

def make_category(title)
    new_params = Hash.new
    new_params[:title] = title
    category = Category.new(new_params)
    category.save
    category.add_folder_for
    return category
end

def process_zip(file)
    unless file.respond_to? :original_filename
	flash[:error] = "You must select a file."
	return false
    end
    name = file.original_filename
    directory = File.join('public', 'images')
    path = File.join(directory, name)
    while File.exists?(path)
	path += "_tmp"
    end
    begin
	File.open(path, "wb") { |f| f.write(file.read) }
	all_photos_succeeded = true
	case name
	    when /\.zip$/ then
		Zip::ZipFile.foreach(path) do |entry|
		    if entry.directory?
			category = Category.find(:first, :conditions => ['title = ?', entry.name.chop])
			make_category(entry.name.chop) unless category
		    elsif entry.file?
			parsed_name = entry.name.split(/(\/|\\)/)
			category = Category.find(:first, :conditions => ['title = ?', parsed_name[0]])
			unless category
			    category = make_category(parsed_name[0])
			end
			photo_params = Hash.new
			photo_params[:image] = parsed_name[2]
			photo_params[:category_id] = category.id
			photo_params[:title] = parsed_name[2].split('.')[0]
			photo = Photo.new(photo_params)
			if photo.save
			    entry.extract(File.join('public', 'images', entry.name))
			    Photo.add_files_for(parsed_name[2], parsed_name[0])
			else
			    flash[:warning] ||= ""
			    flash[:warning] += "Upload of #{entry.name} was not successful.\n"
			    all_photos_succeeded = false
			end
		    end
		end
	    else
		flash[:error] = "Filetype not supported."
		return false
	end
    ensure
	File.delete(path) if File.exists? path
    end
    flash[:notice] ||= ""
    if all_photos_succeeded
	flash[:notice] += "The photos were uploaded successfully."
    else
	flash[:notice] += "Some photos were not uploaded successfully."
    end
    return true
end

class ZipsController < ApplicationController
    layout 'standard'
    def new
	redirect_to :controller => 'posts', :action => 'index' unless session[:logged_in]
    end

    def create
	zip = params[:zip].zip
	respond_to do |format|
	    if process_zip(zip.flatten[1])
		format.html { redirect_to :controller => 'categories', :action => 'index' }
	    else
		format.html { redirect_to :action => 'new' }
	    end
	end
    end
end
