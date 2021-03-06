class PetsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    if params[:query].present?
      sql_query = "name ILIKE :query OR category ILIKE :query"
      @pets = Pet.where(sql_query, query: "%#{params[:query]}%").where.not(latitude: nil, longitude: nil)
    else
      @pets = Pet.where.not(latitude: nil, longitude: nil)
    end

    @markers = @pets.map do |pet|
      {
        lat: pet.latitude,
        lng: pet.longitude,
        infoWindow: { content: render_to_string(partial: "/pets/map_box", locals: { pet: pet }) }

      }
    end
  end

  def new
    @pet = Pet.new
  end

  def create
    pet = Pet.new(pet_params)
    pet.user = current_user
    if pet.save
      redirect_to dashboard_path(pet)
    else
    end
  end

  def show
    @pet = Pet.find(params[:id])
    @booking = Booking.new
  end

  def edit
    @pet = Pet.find(params[:id])
  end

  def update
    @pet.update(pet_params)
    redirect_to pet_path(@pet)
  end

  def destroy
    pet = Pet.find(params[:id])
    pet.user = current_user
    if pet.destroy
      redirect_to pets_path
    else
    end
  end



  private

  def pet_params
    params.require(:pet).permit(:name, :location, :description, :photo, :category)
  end

end
