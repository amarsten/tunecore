class Artist < ApplicationRecord
	has_many :albums
	has_many :tracks

	def self.search_by_name(query)
		where(
			self.arel_table[:name]
			.lower
			.matches("%#{query}%")
		)
	end
end
