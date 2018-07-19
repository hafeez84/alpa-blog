class SessionsController < ApplicationController
  def new
    if logged_in?
      redirect_to user_path(current_user)
    end
  end
  
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:success] = "You have successfully logged in !"
      redirect_to user_path(user)
    else
      flash.now[:danger] = "Please check your email and password and try again !"
      render 'new'
    end
  end
  
  def destroy
    session[:user_id] = nil
    flash[:success] = "you have logged out"
    redirect_to login_path
    
  end
  
end