# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Author.delete_all
Category.delete_all
Book.delete_all
User.delete_all

Author.create(name: 'Adam', email: 'Adam@gmail.com')
Author.create(name: 'Michael', email: 'Michael@gmail.com')
Author.create(name: 'Peter', email: 'Peter@gmail.com')


Category.create(name: 'Sports')
Category.create(name: 'Musics')
Category.create(name: 'IT')
Category.create(name: 'Animals')

admin = User.create(email: "admin@gmail.com", password: "123456")
admin.add_role "admin"

