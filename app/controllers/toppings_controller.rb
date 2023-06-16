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
    @topping, notice = Topping.create_or_update(topping_params)
    redirect_to @topping, notice: notice
  end

  def edit
    @toppings = Topping.all
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
    @topping.update(in_stock: false)
    redirect_to toppings_path, notice: 'Topping was successfully marked as out of stock'
  end

  private

  def set_topping
    @topping = Topping.find(params[:id])
  end

  def topping_params
    params.require(:topping).permit(:name)
  end
end
