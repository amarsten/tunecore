class Track < ApplicationRecord
	belongs_to :artist
	belongs_to :album

	def self.search_by_name(query)
		where(
			self.arel_table[:name]
			.lower
			.matches("%#{query}%")
		)
	end
end
