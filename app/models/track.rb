class Track < ApplicationRecord
	belongs_to :artist
	belongs_to :album

	def self.search(name: '%', album: '%', artist: '%')
		joins(:album, :artist)
		.where("tracks.name LIKE ? AND albums.name LIKE ? AND artists.name LIKE ?", 
			"%#{name}%", "%#{album}%", "%#{artist}%")
	end
end
