class Category < ApplicationRecord
	has_many :conections 
	has_many :posts ,through: :conections
end
