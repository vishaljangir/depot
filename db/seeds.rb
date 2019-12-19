# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Product.delete_all
User.delete_all
5.times do |t|
Product.create!(title: "seven Mo #{t}",
				description: %{seven-mobile-apps-in-seven-weeks Jul 29, 
								2016 - Over seven weeks you'll build seven 
								different mobile apps using seven different 
								tools. You'll start out with Mobile Web; 
								develop native apps on iOS, Android, and Windows
								; and finish by building apps for multiple operating 
								systems using the native cross-platform solutions 
								RubyMotion, React Native, and Xamarin.},
				image_url: "animation.jpg",
				price: 26.00
				)
end


User.create!( name: "demo", password: "123456", password_confirmation: "123456" )