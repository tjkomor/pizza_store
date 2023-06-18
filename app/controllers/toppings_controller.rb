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
    @topping = Topping.find(params[:id])
    if @topping.update(topping_params)
      redirect_to toppings_path
    else
      flash[:notice] = 'There was an error updating the topping: ' + @topping.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    @topping = Topping.find(params[:id])
    @topping.destroy
    redirect_to toppings_path, notice: 'Topping was successfully deleted and removed from associated pizzas'
  end

  private

  def set_topping
    @topping = Topping.find(params[:id])
  end

  def topping_params
    params.require(:topping).permit(:name, :in_stock)
  end
end
