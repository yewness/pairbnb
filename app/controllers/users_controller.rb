class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      create_braintree_customer(user: @user)
      session[:user_id] = @user.id
      redirect_to "/"
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to users_path
  end

  private
    def user_params
      params.require(:user).permit(:email, :name)
    end

    def set_user
      @user = User.find(params[:id])
    end

    def authenticate_user!
      redirect_to "/" unless session[:user_id].present?
    end

    def create_braintree_customer(user:)
      result = Braintree::Customer.create(user_params.slice(:name, :email))
      if result.success?
        user.update_attribute(:customer_id, result.customer.id)
      else
        logger.error "Couldn't find"
      end
    end
end