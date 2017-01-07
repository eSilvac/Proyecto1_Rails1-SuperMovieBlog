class ApplicationController < ActionController::Base
  
  Tmdb::Api.key("aca8754b338850c1647406ab99cc1098")

  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    added_attrs = [:username, :email, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

	private
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

		def url_video(url)
			Tmdb::Movie.trailers(url, external_source: 'imdb_id').youtube.first.source
		end
    	helper_method :url_video

    	def rating_top(posts)
    		arr = []
    		cont = 0
    		posts.each do |rating|
    			arr << { id: rating.id, rating: OMDB.id(url_edit(rating.imdb_url)).imdb_rating, poster:OMDB.id(url_edit(rating.imdb_url)).poster  }
    			
    		end
    		ar = arr.sort_by! { |hsh| hsh[:rating]}
			return ar.reverse

    	end
    	helper_method :rating_top
end
