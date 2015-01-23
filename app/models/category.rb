class Category < ActiveRecord::Base

	before_validation :format_value

	has_many :books, dependent: :destroy

	validates :name, presence: true, uniqueness: true, length: {maximum: 50,
		too_long: '%{count} characters is the maximum allowed.'}

	private 

	def format_value
		self.name = self.name.squeeze(' ').strip.titleize
	end
	
end
