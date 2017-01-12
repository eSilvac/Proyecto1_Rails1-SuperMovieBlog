require 'redcarpet/render_strip'

module ApplicationHelper


	def markdown(text)
		markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML,
	                                      no_intra_emphasis: true,
	                                      fenced_code_blocks: true,
	                                      disable_indented_code_blocks: true,
	                                      autolink: true,
	                                      tables: true,
	                                      underline: true,
	                                      highlight: true
	                                     )
	   return markdown.render(text).html_safe
	 end
	 def without_markdown(text)
	 	markdown = Redcarpet::Markdown.new(Redcarpet::Render::StripDown)
	 	return markdown.render(text).html_safe
	 end

	

	def url_video(url)
		Tmdb::Api.key("aca8754b338850c1647406ab99cc1098")
		Tmdb::Movie.trailers(url, external_source: 'imdb_id').youtube.first.source
	end

	def rating_top(posts)
  		arr = []
  		cont = 0
  		posts.each do |rating|
  			arr << { id: rating.id, rating: OMDB.id(url_edit(rating.imdb_url)).imdb_rating, poster:OMDB.id(url_edit(rating.imdb_url)).poster  }		
  		end
  		ar = arr.sort_by! { |hsh| hsh[:rating]}
		return ar.reverse
  	end

  	
end
