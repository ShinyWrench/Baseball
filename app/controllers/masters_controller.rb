include ActionView::Helpers::NumberHelper

class MastersController < ApplicationController

	def index
		@master = Master.new
	end

	def show

		@master = Master.find(params[:playerID])

		battings = @master.battings
		pitchings = @master.pitchings

		playerID = params[:playerID]

		#the key/value pairs set right here are for column titles that need different names in the view vs. their names in the database
		@batting_stat_columns = {
			"yearID" => "Year",
			"teamID" => "Team",
			"lgID" => "Lg."
		}

		#set key/value pairs for the rest of the column titles (exclude the columns that were already given titles and some unwanted columns)
		battings.column_names.each do |c|
			if !@batting_stat_columns.keys.include?(c) && !["playerID", "stint", "G_batting", "G_old"].include?(c)
				@batting_stat_columns[c] = c
			end
		end

		#add stat columns for stats that need to be calculated
		@batting_stat_columns["AVG"] = "AVG"

		#get team names with raw SQL query and generate hash to identify them by teamID and yearID
		batting_team_names = {}
		Master.find_by_sql(
			"SELECT Teams.name, Batting.teamID, Batting.yearID FROM Batting INNER JOIN Teams ON Batting.teamID = Teams.teamID AND Batting.yearID = Teams.yearID WHERE Batting.playerID = '#{playerID}'"
		).each{|r| batting_team_names["#{r.teamID}-#{r.yearID}"] = r.name}

		#build stat lines
		@batting_lines = battings.collect do |b|

			if b.attributes.collect{|k, v| !v.nil? ? 1 : 0}.reduce(:+) != 6
				@batting_stat_columns.collect do |k, v|

					#get team name by teamID and yearID
					if k == "teamID"
						batting_team_names["#{b.teamID}-#{b.yearID}"]

					#batting average
					elsif k =="AVG"
						if !b.AB.nil? && b.AB > 0 && !b.H.nil?
							batting_average(b.H, b.AB)
						else
							nil
						end

					#just show value from database for everything else
					else
						b.attributes[k]
					end
				end
			end
		end

		#remove nil values resulting from above @battings.collect
		@batting_lines.compact! if !@batting_lines.nil?

		#totals for most stat columns
		@batting_totals = [];
		@batting_stat_columns.each do |k, v|
			case k
				#total of unique years played, total of unique teams played for
				when "yearID", "teamID"
					@batting_totals.push battings.collect{|b| b[k]}.uniq.length

				#no total for leagues
				when "lgID"
					@batting_totals.push nil

				#batting average
				when "AVG"

					career_AB = battings.collect{|b| b.AB.nil? ? 0 : b.AB}.reduce(:+)
					career_hits = battings.collect{|b| b.H.nil? ? 0 : b.H}.reduce(:+)

					@batting_totals.push batting_average(career_hits, career_AB)

				#otherwise sum the column (and substitute 0's for NULL values)
				else
					@batting_totals.push battings.collect{|b| 
						b[k] == nil ? 0 : b[k]
					}.reduce(:+)
				end
		end

		#PITCHING
		if pitchings.length > 0
			#the key/value pairs set right here are for column titles that need different names in the view vs. their names in the database
			@pitching_stat_columns = {
				"yearID" => "Year",
				"teamID" => "Team",
				"lgID" => "Lg."
			}

			#set key/value pairs for the rest of the column titles (exclude the columns that were already given titles)
			pitchings.column_names.each do |c|
				if !@pitching_stat_columns.keys.include?(c) && !["playerID", "stint"].include?(c)
					@pitching_stat_columns[c] = c
				end
			end

			#get team names with raw SQL query and generate hash to identify them by teamID and yearID
			pitching_team_names = {}
			Master.find_by_sql(
				"SELECT Teams.name, Pitching.teamID, Pitching.yearID FROM Pitching INNER JOIN Teams ON Pitching.teamID = Teams.teamID AND Pitching.yearID = Teams.yearID WHERE Pitching.playerID = '#{playerID}'"
			).each{|r| pitching_team_names["#{r.teamID}-#{r.yearID}"] = r.name}

			#build stat lines
			@pitching_lines = pitchings.collect do |p|
				@pitching_stat_columns.collect do |k, v|
					
					#get team name by teamID and yearID
					if k == "teamID"
						pitching_team_names["#{p.teamID}-#{p.yearID}"]

					#formatting convention for batting average
					elsif k == "BAOpp"
						if !p.attributes["BAOpp"].nil?
							number_with_precision(p.attributes["BAOpp"], precision: 3).to_s.sub(/^0/, "")
						else
							nil
						end

					#formatting convention for ERA
					elsif k == "ERA"
						if p.attributes[k] == 0 || p.attributes[k].nil?
							nil
						else
							number_with_precision(p.attributes[k], precision: 2)
						end

					#just show value from database for everything else
					else
						p.attributes[k]
					end
				end
			end

			#totals for most stat columns
			@pitching_totals = [];
			@pitching_stat_columns.each do |k, v|
				case k
					#total of unique years played, total of unique teams played for
					when "yearID", "teamID"
						@pitching_totals.push pitchings.collect{|b| b[k]}.uniq.length

					#no total for leagues
					when "lgID"
						@pitching_totals.push nil

					#ERA = ER / IPouts * 27
					when "ERA"
						
						career_IPouts = pitchings.collect{|line| line.IPouts.nil? ? 0 : line.IPouts}.reduce(:+).to_f

						#don't divide by 0!
						if career_IPouts == 0
							career_ERA = nil
						else
							career_ERA = number_with_precision(pitchings.collect{|line| line.ER.nil? ? 0 : line.ER}.reduce(:+) / career_IPouts * 27, precision: 2)
						end

						@pitching_totals.push career_ERA

					#BAOpp = H / (BFP - BB - HBP - SH - SF)
					when "BAOpp"
						less = ["BB", "HBP", "SH", "SF"].collect{|stat|
							pitchings.collect{|line|
								line.attributes[stat].nil? ? 0: line.attributes[stat]
							}.reduce(:+)
						}.reduce(:+)
						faced = pitchings.collect{|line|
							line.attributes["BFP"].nil? ? 0 : line.attributes["BFP"]
						}.reduce(:+)
						hits = pitchings.collect{|line|
							line.attributes["H"].nil? ? 0 : line.attributes["H"]
						}.reduce(:+)

						if faced - less > 0
							avg = hits / (faced - less).to_f
							@pitching_totals.push number_with_precision(avg, precision: 3).to_s.sub(/^0/, "")
						else
							@pitching_totals.push nil
						end

					#otherwise sum the column (and substitute 0's for NULL values)
					else
						@pitching_totals.push pitchings.collect{|b| 
							b[k] == nil ? 0 : b[k]
						}.reduce(:+)
					end
			end
		else
			@pitching_lines = []
		end
	end

	#clicking on a letter in index.html.erb links to a list of links to all players whose last name starts with that letter
	def letterlinks
		@letter = params[:letter].upcase
		@masters = Master.where("nameLast LIKE (?)", "#{params[:letter]}%").order(:nameLast)
	end

	#when the search box contents change and have only one letter in it, an ajax request is sent for a list of player names and playerIDs whose last name starts with that letter
	def letterlist
		respond_to do |format|
			#format.text {render :text => params[:letter]}
			list_out = Master.where("nameLast LIKE (?)", "#{params[:letter]}%").collect{|m| [m.nameFirst, m.nameLast, m.playerID]}
			format.json {render :json => list_out}
		end
	end

	private

	#calculate batting average and handle formatting convention
	def batting_average(hits, atbats)
		if atbats > 0
			number_with_precision(hits / atbats.to_f, precision: 3).to_s.sub(/^0/, "")
		else
			nil
		end
	end
end
