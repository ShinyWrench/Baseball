class Master < ActiveRecord::Base
	self.table_name = "Master"
	#self.primary_key = :playerID
	has_many :battings, foreign_key: "playerID"
	has_many :pitchings, foreign_key: "playerID"
end
