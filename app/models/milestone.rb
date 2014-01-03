class Milestone < ActiveRecord::Base
	belongs_to :goal
	validates :title, presence: true
end
