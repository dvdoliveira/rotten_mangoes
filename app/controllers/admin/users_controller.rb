class Admin::UsersController < ApplicationController
  before_filter :restrict_admin

  def index
    @users_admin = User.all
  end

  def new
    @user_admin = User.new
  end

  def edit
    @user_admin = User.find(params[:id])
  end

  def create
    @user_admin = User.new(user_params)

    if @user_admin.save
      redirect_to admin_users_path, notice: "User was created!"
    else
      render :new_admin_user
    end
  end

  def update
    @user_admin = User.find(params[:id])

    if @user_admin.update_attributes(user_params)
      redirect_to admin_users_path, notice: "User was updated!"
    else
      render :edit_admin_user
    end
  end

  protected

  def user_params
    params.require(:user).permit(:email, :firstname, :lastname, :password, :password_confirmation, :admin)
  end

end