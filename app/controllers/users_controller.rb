class UsersController < ApplicationController
  before_action :authenticate_user!, except: :show

  before_action :set_current_user, except: :show

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to @user, notice: I18n.t('controllers.users.create')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: I18n.t('controllers.users.update')
    else
      render :edit, status: :unprocessable_entity
    end
  end


  private

  def set_current_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:name, :email)
  end
end
