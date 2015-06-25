class Admin::UsersController < ApplicationController
  before_filter :restrict_admin

  def index
    @users_admin = User.all.page(params[:page]).per(5)
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

  def destroy
    @user_admin = User.find(params[:id])
    @user_admin.destroy
    UserMailer.delete_notification(@user_admin).deliver
    redirect_to admin_users_path
  end

  def impersonate
    user = User.find(params[:user_id])
    if user.admin
      redirect_to admin_users_path, notice: "You can't switch into admin accounts"
    else
      session[:admin_session] = session[:user_id]
      session[:user_id] = user.id
      redirect_to movies_path, notice: "Switched into #{user.full_name}'s account"
    end
  end

  def stop_impersonating
    user = User.find(session[:admin_session])
    session[:user_id] = user.id
    session[:admin_session] = nil

    redirect_to movies_path, notice: "Switched back to admin account, #{user.full_name}"
  end

  protected

  def user_params
    params.require(:user).permit(:email, :firstname, :lastname, :password, :password_confirmation, :admin)
  end

end