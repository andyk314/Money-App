class UsersController < ApplicationController
	def index
		@users = User.all
		@user = User.new
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(users_params)
		if @user.save
			redirect_to action: 'index'
			flash[:notice] = 'sucessfully added user'	
		else
			render action: 'new'
		end
	end

private

  def users_params
    params.require(:user).permit(:name, :username, :password)
  end



end