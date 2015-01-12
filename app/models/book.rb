class Book < ActiveRecord::Base

	belongs_to :author
	belongs_to :category

	validates :title, presence: true, uniqueness: true
	validates :category, :author, presence: {message: "must have value"} 
	validates :year, inclusion: { in: 1900..Date.today.year, message:  "should be a year from 1900 to #{Date.today.year}"}

end
