class ListingsController < ApplicationController
  before_action :set_listing, only: [:show, :edit, :update, :destroy]

  def index
    @listings = Listing.order(created_at: :desc).paginate(page: params[:page], per_page: 2)
  end

  def show
  end

  def new
    @listing = Listing.new
  end

  def edit
  end

  def create
    listing_params[:user_id] = current_user.id
    @listing = Listing.new(listing_params)

    respond_to do |format|
      if @listing.save
        @listing.create_tags(params[:listing][:all_tags])
        format.html { redirect_to @listing, notice: 'Listing was successfully created.' }
        format.json { render :show, status: :created, location: @listing }
      else
        format.html { render :new }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @listing.update(listing_params)
        @listing.create_tags(params[:listing][:all_tags])
        format.html { redirect_to @listing, notice: 'Listing was successfully updated.' }
        format.json { render :show, status: :ok, location: @listing }
      else
        format.html { render :edit }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @listing.destroy
    respond_to do |format|
      format.html { redirect_to listings_url, notice: 'Listing was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_listing
      @listing = Listing.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def listing_params
      params.require(:listing).permit(:title, :description, :home_type, :room_type, :city, :user_id, :all_tags, :photo)
    end
end
