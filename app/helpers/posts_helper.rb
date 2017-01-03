module PostsHelper
	def form_title
	  	@post.new_record? ? "Crear Post" : "Editar Post"
	end
end
