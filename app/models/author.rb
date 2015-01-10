class Author < ActiveRecord::Base

	validates :name, :email, presence: true, uniqueness: true
	validates_email_format_of :email, :message => 'is not looking good', :if => :have_values?

	def have_values?
		name != ''
		email != ''	
	end
end
