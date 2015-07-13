class PitchingsController < ApplicationController
	def show
		@pitching = Pitching.where(playerID: params[:playerID], yearID: params[:yearID])[0]
	end
end
