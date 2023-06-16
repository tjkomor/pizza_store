class PizzasController < ApplicationController
  before_action :set_pizza, only: [:show, :edit, :update, :destroy]
  before_action :set_toppings, only: [:new, :create, :edit, :update]

  def index
    @pizzas = Pizza.all
  end

  def show
  end

  def new
    @pizza = Pizza.new
  end

  def create
    @pizza = Pizza.new(pizza_params)
    
    if @pizza.save
      flash[:notice] = 'Pizza was successfully created.'
      redirect_to @pizza
    else
      render :new
    end
  end

  def edit
    @pizza = Pizza.find(params[:id])
  end

  def update
    @pizza = Pizza.new(pizza_params)

    if @pizza.save
      @pizza.update(pizza_params)
      redirect_to @pizza, notice: 'Pizza was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @pizza.destroy
    redirect_to pizzas_url, notice: 'Pizza was successfully destroyed.'
  end

  def home
    @pizzas = Pizza.all
  end

  private

  def set_pizza
    @pizza = Pizza.find(params[:id])
  end
  
  def set_toppings
    @toppings = Topping.all
  end

  def pizza_params
    params.require(:pizza).permit(:name, topping_ids: [])
  end
end
