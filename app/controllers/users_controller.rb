class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

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
      params.require(:user).permit(:title, :body)
    end

    def set_user
      @user = Blog.find(params[:id])
    end

    def authenticate_user!
      redirect_to "/" unless session[:user_id].present?
    end
end