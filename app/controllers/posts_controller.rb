class PostsController < ApplicationController
	
	before_action :authenticate_user!, except: [:index, :show]

	def index
		@posts_top = Post.all
		@posts = Post.order('created_at DESC')
			if params[:search].present?
				@posts = Post.order(params[:search])
			end
			if params[:genere].present?
				temp = Array.new
				@posts.each do |post|
					if post.categories.ids.include?(params[:genere].to_i)
						temp << post
					end
				end
				@posts = temp
			end
	end

	def new
		@post = Post.new
	end

	def create
		@post = Post.create(post_params)
		@post.user = current_user
		if @post.save
			category_create(@post)
			flash[:success] = "Post Publicado Correctamente"
			redirect_to posts_path
		else
			render :new
		end
	end

	def edit 
		@post = Post.find(params[:id])
	end

	def update
		@post = Post.find(params[:id])
		@post.categories.destroy_all
		if @post.update(post_params)
			category_create(@post)
			flash[:alert] = "Post Modificado Correctamente"
			redirect_to posts_path
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
		flash[:error] = "Post Eliminado Correctamente"
		redirect_to posts_path
	end
	
	private
	  	def post_params
	  		params.require(:post).permit(:title, :imdb_url, :description)
	  	end
end
