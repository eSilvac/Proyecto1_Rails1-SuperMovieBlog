class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    added_attrs = [:username, :email, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end
  private
  	def category_create(post)
        OMDB.id(url_edit(post.imdb_url)).genre.split(", ").each do |genero|
          	unless Category.exists?(name: genero)
            		Category.create(name: genero)
          	end
        post.categories << Category.find_by(name: genero)
       	end
     end
     helper_method :category_create

    def url_edit(link)
  		num = ""
  		link.split("/").each do |parte|
  			if parte.start_with?("tt")
  				num = parte
  			end	
  		end
  		num
	end	 
	helper_method :url_edit

end
