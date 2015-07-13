class Batting < ActiveRecord::Base
	self.table_name = "Batting"
	belongs_to :master
end
