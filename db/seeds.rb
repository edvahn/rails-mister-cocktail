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
url = "https://www.thecocktaildb.com/api/json/v1/1/random.php"

10.times do
  data = JSON.parse(open(url).read)
  cocktail_data = data["drinks"].first
  break if Cocktail.find_by_name(cocktail_data["strDrink"])
  cocktail = Cocktail.new
  cocktail.name = cocktail_data["strDrink"]
  cocktail.remote_photo_url = cocktail_data["strDrinkThumb"] if cocktail_data["strDrinkThumb"].present?
  cocktail.save!
  15.times do |i|
    ingredient_data_name = cocktail_data["strIngredient#{i+1}"]
    break if ingredient_data_name.empty?
    ingredient = Ingredient.find_or_create_by!(name: ingredient_data_name)
    description = cocktail_data["strMeasure#{i+1}"].present? ? cocktail_data["strMeasure#{i+1}"] : 'some'
    Dose.create!(
      cocktail: cocktail,
      ingredient: ingredient,
      description: description
    )
  end
end


# ingredients["drinks"].each do |b|
#   ingredient = Ingredient.new(name: b["strIngredient1"])
#   ingredient.save!

# end
#   url= https://www.thecocktaildb.com/images/ingredients/ice.png
#   images = ["http://res.cloudinary.com/doyl8dhkb/image/upload/v1511609816/lnuzy1rwse9r5thrc3st.jpg", "http://res.cloudinary.com/doyl8dhkb/image/upload/v1511609817/trbukchn4li4g5g6ibay.jpg", "http://res.cloudinary.com/doyl8dhkb/image/upload/v1511609818/rahtw0ahy5zrbyv9krk8.jpg", "http://res.cloudinary.com/doyl8dhkb/image/upload/v1511609819/h721tvfska6obubiunns.jpg"]
#     desc = ["1cl", "1.5cl", "2cl", "2.5cl", "3cl", "3.5cl", "4cl", "4.5cl", "5cl", "5.5cl", "6cl", "1 drop", "2 drops"]
# 10.times do
#   cocktail = Cocktail.new(name: Faker::Hipster.words(2).join(" ").capitalize)
#   cocktail.remote_photo_url = images.sample
#   cocktail.save!
#    Dose.create!(description: desc.sample, ingredient: Ingredient.all.sample, cocktail: cocktail)

# end
