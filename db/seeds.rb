# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

Review.destroy_all
Booking.destroy_all
Pet.destroy_all
User.destroy_all

10.times do
  puts "creating a user..."
  user = User.new(
    name: Faker::Name.first_name,
    email: Faker::Internet.email,
    password: Faker::Internet.password(6)
    )
  user.save

  Pet.create(
    name: Faker::StarWars.character,
    description: Faker::StarWars.wookiee_sentence,
    category: Faker::StarWars.specie,
    location: Faker::Address.city,
    user_id: user.id,
    )
end

Pet.update_all(photo:"http://www.thedailyrecords.com/wp-content/uploads/2017/01/Beagle-Top-Most-Famous-Beautiful-Dogs-Breeds-2018.jpg")

puts "end of db"
