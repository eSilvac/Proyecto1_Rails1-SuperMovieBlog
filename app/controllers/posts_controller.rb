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
			redirect_to posts_path, notice: "Post Publicado Correctamente"
		else
			render :new
		end
	end

	def edit 
		@post = Post.find(params[:id])
	end

	def update
		@post = Post.find(params[:id])
		if @post.update(post_params)
			redirect_to posts_path, notice: "Post Modificado Correctamente"
		else
			render :new
		end
	end

	def show
		@post = Post.find(params[:id])
	end

	def destroy
		@post = Post.find(params[:id])
		@post.destroy
		redirect_to posts_path, notice: "Post Eliminado"
	end
	
	private
	  	def post_params
	  		params.require(:post).permit(:title, :imdb_url, :description)
	  	end
end
