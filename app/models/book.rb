class Book < ActiveRecord::Base

	before_validation :format_value

	belongs_to :author
	belongs_to :category

	has_attached_file :photo, :styles => {:small => "150x150>" },
					:url => "/assets/books/:id/:style/:basename.:extension",
  					:path => ":rails_root/public/assets/books/:id/:style/:basename.:extension",
  					:default_url => "no-image_:style.png"

	validates_attachment_size :photo, :less_than => 2.megabytes
	validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png']

	validates :title, presence: true, uniqueness: true, length: {maximum: 100,
		too_long: '%{count} characters is the maximum allowed.'}
	validates :category, :author, :year, presence: {message: "must have value"} 
	validates :year, inclusion: { in: 1900..Date.today.year, message:  "should be a year from 1900 to #{Date.today.year}"}, :if => :year?

	private

	def format_value
		self.title = self.title.squeeze(' ').strip.titleize
	end
end
