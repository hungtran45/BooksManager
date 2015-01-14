class Author < ActiveRecord::Base

	before_validation :format_value
	
	has_many :books, dependent: :destroy

	validates :name, :email, presence: true, uniqueness: true, length: {maximum: 120,
		too_long: '%{count} characters is the maximum allowed.'}
	validates_email_format_of :email, :message => 'is not looking good', :if => :email?

	private

	def format_value
		self.name = self.name.squeeze(' ').strip.titleize
		self.email = self.email.downcase
	end
end
