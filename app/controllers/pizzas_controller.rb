class PizzasController < ApplicationController

  def index
    @pizzas = Pizza.all
  end
  
  def new
    @pizza = Pizza.new
    puts "@pizzas is now: #{@pizzas.inspect}"
  end

  def create
    @pizza = Pizza.new(pizza_params)

    if params[:pizza][:topping_names]
      params[:pizza][:topping_names].each do |topping_name|
        @pizza.toppings.build(name: topping_name)
      end
    end

    if @pizza.save
      redirect_to @pizza, notice: 'Pizza was successfully created.'
    else
      render :new
    end
  end

  def show
    @pizza = Pizza.find(params[:id])
  end

  private

  def pizza_params
    params.require(:pizza).permit(:name)
  end
end
