class UsersController < ApplicationController 
  before_action :set_user, only: [:edit, :update]
  

  def edit #課題対応で追加 
    @user = User.find(params[:id])
  end
  
  def update #課題対応で追加
    if @user.update(user_profile)
      flash[:success] = "Updated profile"
      redirect_to @user
    else
      # 保存に失敗した場合は編集画面へ戻す
      render 'edit'
    end
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      flash[:info] = "logged in as #{@user.name}"
      redirect_to @user
    else
      flash[:danger] = 'invalid email/password combination'
      render 'new'
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end
  
  def user_profile
    params.require(:user).permit(:name, :email, :profile)
  end
  
  def set_user
    @user = User.find(params[:id])
  end
  
  
end
