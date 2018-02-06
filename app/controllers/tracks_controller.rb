class TracksController < ApplicationController

	def index
		@results = []
	end

	def search
		@results = Track.search(name: params[:name], album: params[:album], artist: params[:artist])
		respond_to do |format|
			format.js
		end
	end
end