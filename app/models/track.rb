class Track < ApplicationRecord
	belongs_to :artist
	belongs_to :album

	def self.search(name: '%', album: '%', artist: '%')
		# results are ranked by of how many fields match the 
		# beginning of it's corresponding input
		by_relevance = %(
		CASE
		  WHEN albums.name NOT LIKE "#{artist}%" THEN 0
		  WHEN artists.name NOT LIKE "#{album}%" THEN 1
          WHEN tracks.name NOT LIKE "#{name}%" THEN 2
          ELSE 3
	    END DESC
		)

		includes(:album, :artist)
		.references(:albums, :artists)
		.where("tracks.name LIKE :name
			AND albums.name LIKE :album 
			AND artists.name LIKE :artist", 
			{name: "%#{name}%", album: "%#{album}%", artist: "%#{artist}%"})
		.order(by_relevance)
	end
end