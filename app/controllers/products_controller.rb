class ProductsController < ApplicationController  
  before_filter :load_product, :except => [:new, :index, :create]
  before_filter :authenticate_user!, :except => [:index]
  attr_reader :per_page
  
  def new
    @product = Product.new
  end
  
  def create
    @product = Product.new(params[:product])
    if @product.save
      flash[:notice] = "Produkt zostal dodany pomyslnie" 
      redirect_to products_path
    else
      render :action => :new
    end
  end

  def index
    @search = Product.search(params[:search])
    @products = @search.paginate(:page => params[:page], :per_page => 2)  
  end

  def show
  end
  
  def update
     @product.update_attributes(params[:product])
     redirect_to @product
   end
  
  def destroy
    @product.destroy
    redirect_to products_path
  end
  
  
  private 
  
  def find_cart 
    session[:cart] ||= Cart.new 
  end 
end
