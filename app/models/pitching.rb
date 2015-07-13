class Pitching < ActiveRecord::Base
	self.table_name = "Pitching"
	belongs_to :master
end
