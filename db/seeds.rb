# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'json'
require 'open-uri'
require 'faker'
require 'cloudinary'

puts "Let's seed!"
puts 'cleaning the DB'

Ingredient.destroy_all
Cocktail.destroy_all
puts 'DB cleaned'

puts "Seeding the DB"
url = "http://www.thecocktaildb.com/api/json/v1/1/list.php?i=list"
ingredients = JSON.parse(open(url).read)

ingredient_range = []

ingredients["drinks"].each do |b|
  ingredient = Ingredient.new(name: b["strIngredient1"])
  ingredient.save!

end

  images = ["http://res.cloudinary.com/doyl8dhkb/image/upload/v1511609816/lnuzy1rwse9r5thrc3st.jpg", "http://res.cloudinary.com/doyl8dhkb/image/upload/v1511609817/trbukchn4li4g5g6ibay.jpg", "http://res.cloudinary.com/doyl8dhkb/image/upload/v1511609818/rahtw0ahy5zrbyv9krk8.jpg", "http://res.cloudinary.com/doyl8dhkb/image/upload/v1511609819/h721tvfska6obubiunns.jpg"]
    desc = ["1cl", "1.5cl", "2cl", "2.5cl", "3cl", "3.5cl", "4cl", "4.5cl", "5cl", "5.5cl", "6cl", "1 drop", "2 drops"]
10.times do
  cocktail = Cocktail.new(name: Faker::Hipster.words(2).join(" ").capitalize)
  cocktail.remote_photo_url = images.sample
  cocktail.save!
   Dose.create!(description: desc.sample, ingredient: Ingredient.all.sample, cocktail: cocktail)

end
