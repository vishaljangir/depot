class UsersController < ApplicationController
  skip_before_action :authorize, only: [:new, :create]
  before_action :set_user, only: [:edit, :update, :destroy]
	def index
		@users = User.order(:name)
	end

  def new
  	@user = User.new
  end

  def edit
  		
  end

  def create
  	@user = User.new(user_params)
  	respond_to do |format|
	  	if @user.save
	  		format.html { redirect_to users_url, notice: "User #{@user.name} was successfully created."}
	  	else
	  		format.html { render :new }
	  	end
	  end	
  end

  def update
    respond_to do |format|
	  	if @user.update(user_params)
	  		format.html { redirect_to users_url, notice: "User #{@user.name} was successfully updated."}
	  	else
	  		format.html { render :edit }
	  	end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }   
    end
  end

  rescue_from 'User::Error' do |exception|
    redirect_to users_url, notice: exception.message
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
  	params.require(:user).permit(:name, :current_password, :password, :password_confirmation)
  end
end
