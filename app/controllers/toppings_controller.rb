class ToppingsController < ApplicationController
  before_action :set_topping, only: [:show, :edit, :update, :destroy]

  def index
    @toppings = Topping.all
  end

  def show
  end

  def new
    @topping = Topping.new
  end

  def create
    @topping = Topping.new(topping_params)
    if @topping.save
      redirect_to @topping, notice: 'Topping was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @topping.update(topping_params)
      redirect_to @topping, notice: 'Topping was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @topping = Topping.find(params[:id])
    @topping.destroy
    redirect_to toppings_path, notice: 'Topping was successfully deleted'
  end

  private

  def set_topping
    @topping = Topping.find(params[:id])
  end

  def topping_params
    params.require(:topping).permit(:name)
  end
end
