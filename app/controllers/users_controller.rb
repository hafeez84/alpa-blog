class UsersController < ApplicationController

  before_action :set_user, only:[:edit, :update, :show, :destroy]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  require 'users_controller'
  attr_accessor :api_v1
  @@api_v1 = Api::V1::UsersController.new

  def test
    render json: {status: 'SUCCESS', message:"Loaded successfully", data: @@api_v1.index}, status: :ok
  end

  def new
    @user = User.new
    @up = AvatarUploader.new
  end

  def create
    @user = User.new(user_params)
    @up = params[:avatar]
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Welcome to Alpha-Blog #{@user.username}"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] = "your account has been updated successfully !"
      redirect_to user_path(current_user)
    else
      render 'edit'
    end
  end

  def show
    @u_art = @user.articles.paginate(page: params[:page], per_page: 5)
  end


  def index
    # @@api_v1.index
    @users = User.paginate(page: params[:page], per_page: 5)
  end

  def destroy
    username = @user.username
    if @user.destroy and current_user.admin?
      flash[:danger] = "You have deleted #{username} !"
      redirect_to users_path
    else
      flash[:danger] = "You have deleted your account !"
      session[:user_id] = nil
      redirect_to articles_path
    end

  end





  private #------------------------

  def user_params
    params.require(:user).permit(:username, :email, :password, :avatar)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def require_same_user
    if current_user != @user and !current_user.admin?
      flash[:danger] = "You can only edit your own profile !"
      redirect_to articles_path
    end
  end

end
