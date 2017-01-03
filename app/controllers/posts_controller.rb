class PostsController < ApplicationController
	
	before_action :authenticate_user!, except: [:index, :show]

	def index
		@posts = Post.all
	end

	def new
		@post = Post.new
	end

	def create
		@post = Post.create(post_params)
		@post.user = current_user
		if @post.save
			@post.update(imdb_url: imdb_url_edit(@post.imdb_url))
			redirect_to posts_path, notice: "Post Publicado Correctamente"
		else
			render :new
		end
	end

	def show
		@post = Post.find(params[:id])
	end
	
	private
	  	def post_params
	  		params.require(:post).permit(:title, :imdb_url, :description)
	  	end

	  	def imdb_url_edit(link)
	  		num = ""
	  		link.split("/").each do |parte|
	  			if parte.start_with?("tt")
	  				num = parte.delete "tt"
	  			end	
	  		end
	  		num
	  	end
end
