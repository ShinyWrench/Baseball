class BattingsController < ApplicationController
	def show
		@batting = Batting.where(playerID: params[:playerID], yearID: params[:yearID])[0]
	end
end
