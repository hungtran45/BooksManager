class Book < ActiveRecord::Base

	before_validation :format_value

	belongs_to :author
	belongs_to :category

	validates :title, presence: true, uniqueness: true, length: {maximum: 100,
		too_long: '%{count} characters is the maximum allowed.'}
	validates :category, :author, presence: {message: "must have value"} 
	validates :year, inclusion: { in: 1900..Date.today.year, message:  "should be a year from 1900 to #{Date.today.year}"}

	private

	def format_value
		self.title = self.title.squeeze(' ').strip.titleize
	end
end
