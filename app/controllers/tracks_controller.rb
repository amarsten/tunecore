class TracksController < ApplicationController

	def index
	end

	def search
		@results = Track.search(name: params[:name], album: params[:album], artist: params[:artist])

	end
end