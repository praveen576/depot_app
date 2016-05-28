class CartsController < ApplicationController

  # GET /carts
  # GET /carts.json
  before_filter :find_current_cart, only: [:show, :edit, :update]

  def find_current_cart
    @cart = Cart.find_by_id(params[:id])
    unless @cart
      logger.error "Attempt to access invalid cart #{params[:id]}"
      redirect_to store_url, notice: 'Invalid cart'
    end
  end

  def index
    @carts = Cart.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @carts }
    end
  end

  # GET /carts/1
  # GET /carts/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @cart }
    end
  end
  
  # GET /carts/new
  # GET /carts/new.json
  def new
    @cart = Cart.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @cart }
    end
  end

  # GET /carts/1/edit
  def edit
  end

  # POST /carts
  # POST /carts.json
  def create
    @cart = Cart.new(params[:cart])

    respond_to do |format|
      if @cart.save
        format.html { redirect_to @cart, notice: 'Cart was successfully created.' }
        format.json { render json: @cart, status: :created, location: @cart }
      else
        format.html { render action: "new" }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /carts/1
  # PUT /carts/1.json
  def update
    format.html { render action: "edit" }
    format.json { render json: @cart.errors, status: :unprocessable_entity }
  end

  # DELETE /carts/1
  # DELETE /carts/1.json

  def destroy
    @cart = current_cart
    @cart.destroy
    respond_to do |format|
      format.html { redirect_to store_url }
      format.json { head :ok }
    end
  end
end
