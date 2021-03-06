# == Schema Information
#
# Table name: posts
#
#  id          :integer          not null, primary key
#  title       :string
#  description :text
#  imdb_url    :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Post < ApplicationRecord
	has_many :conections, dependent: :destroy
	has_many :comments, dependent: :destroy
	has_many :categories ,through: :conections
	belongs_to :user
	validates :title , presence: true
	validates :imdb_url, presence: true, format: { with: /\A((http|https):\/\/)?(www.)?(imdb.com.title.tt(\d){7})/, message: "no es valido"} 
	validates :description, presence: true, length: { minimum: 250 }

end
