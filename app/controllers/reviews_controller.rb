class ReviewsController < ApplicationController
  # GET /reviews
  # GET /reviews.json
  def index
    @product = Product.find(params[:product_id])

    @reviews = @product.reviews

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @reviews }
    end
  end

  # GET /reviews/1
  # GET /reviews/1.json
  def show
    @product = Product.find(params[:product_id])
    @review = Review.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @review }
    end
  end

  # GET /reviews/new
  # GET /reviews/new.json
  def new
    @product = Product.find(params[:product_id])
    @review = @product.reviews.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @review }
    end
  end

  # GET /reviews/1/edit
  def edit
    @product = Product.find(params[:product_id])
    @review = Review.find(params[:id])
  end

  # POST /reviews
  # POST /reviews.json
  def create
    @product = Product.find(params[:product_id])
    @review = @product.reviews.new(params[:review])

    respond_to do |format|
      if @review.save
        format.html { redirect_to product_review_url(@product, @review), notice: 'Review was successfully created.' }
        format.json { render json: @review, status: :created, location: @review }
      else
        format.html { render action: "new" }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /reviews/1
  # PUT /reviews/1.json
  def update
    @product = Product.find(params[:product_id])
    @review = Review.find(params[:id])

    respond_to do |format|
      if @review.update_attributes(params[:review])
        format.html { redirect_to product_review_url(@product, @review), notice: 'Review was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reviews/1
  # DELETE /reviews/1.json
  def destroy
    @product = Product.find(params[:product_id])
    @review = Review.find(params[:id])
    @review.destroy

    respond_to do |format|
      format.html { redirect_to product_reviews_url(@product) }
      format.json { head :ok }
    end
  end
end
