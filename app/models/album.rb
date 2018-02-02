class Album < ApplicationRecord
	belongs_to :artist

	def self.search_by_name(query)
		where(
			self.arel_table[:name]
			.lower
			.matches("%#{query}%")
		)
	end
end
