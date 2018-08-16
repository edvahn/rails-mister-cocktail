require 'faker'

class CocktailsController < ApplicationController
  def index
    @cocktails = Cocktail.all
  end

  def show
    @cocktail = Cocktail.find(params[:id])
  end

  def new
    @cocktail = Cocktail.new
  end

  def create
    @cocktail = Cocktail.new(cocktail_params)
    if @cocktail.save
      redirect_to cocktail_path(@cocktail)
    else
      render :new
    end
  end

  def edit
    @cocktail = Cocktail.find(params[:id])
  end

  def update
    @cocktail = Cocktail.find(params[:id])
    @cocktail.update(cocktail_params)

    redirect_to cocktail_path(@cocktail)
  end

  def destroy
    @cocktail = Cocktail.find(params[:id])
    @cocktail.destroy
    redirect_to cocktails_path
  end

  def mixologist
    images = ["http://res.cloudinary.com/doyl8dhkb/image/upload/v1511609816/lnuzy1rwse9r5thrc3st.jpg", "http://res.cloudinary.com/doyl8dhkb/image/upload/v1511609817/trbukchn4li4g5g6ibay.jpg", "http://res.cloudinary.com/doyl8dhkb/image/upload/v1511609818/rahtw0ahy5zrbyv9krk8.jpg", "http://res.cloudinary.com/doyl8dhkb/image/upload/v1511609819/h721tvfska6obubiunns.jpg"]
    @cocktail = Cocktail.new(name: Faker::Hipster.words(2).join(" ").capitalize)
    @cocktail.remote_photo_url = images.sample
    @cocktail.save!
    [3, 4, 5, 6].sample.times do
      desc = ["1cl", "1.5cl", "2cl", "2.5cl", "3cl", "3.5cl", "4cl", "4.5cl", "5cl", "5.5cl", "6cl", "1 drop", "2 drops"]
      @dose = Dose.new(description: desc.sample, ingredient_id: (Ingredient.first.id..Ingredient.last.id).to_a.sample)
      @dose.cocktail = @cocktail
      @dose.save
    end
  end

  private

  def cocktail_params
    params.require(:cocktail).permit(:name)
  end
end
