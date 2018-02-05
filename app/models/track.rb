class Track < ApplicationRecord
	belongs_to :artist
	belongs_to :album

	def self.find_by_string(query)
		includes(:album, :artist).
		where("tracks.name LIKE ? OR artists.name LIKE ? OR albums.name LIKE ?", 
			"%#{query}%", "%#{query}%", "%#{query}%").references(:artists, :albums)
	end
end
