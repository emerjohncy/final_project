class ShoesController < ApplicationController
  before_action :authenticate_user!, except: ['show']
  before_action :get_shoe, only: ['show', 'edit', 'update', 'destroy']
  before_action :restrict_access, only: ['edit', 'update', 'destroy']
  
  def index
    @shoes = current_user.shoes.all
  end

  def show
  end

  def new
    @shoe = current_user.shoes.build
  end

  def create
    @shoe = current_user.shoes.build(shoe_params)

    if @shoe.save
      redirect_to @shoe
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @shoe.update(shoe_params)
      redirect_to @shoe
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @shoe.destroy

    redirect_to shoes_path, status: :see_other
  end

  private
  def get_shoe
    @shoe = Shoe.find(params[:id])
  end

  def shoe_params
    params.require(:shoe).permit(:size, :condition, :color, :model, :brand, :image)
  end

  def restrict_access
    if @shoe.present? && current_user.id != @shoe.user_id
      redirect_to shoe_path(params[:id])
    end
  end
end