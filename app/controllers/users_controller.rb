class UsersController < ApplicationController
	def index
		@users = User.all
	end

	def new
		@user = User.new
	end

	def create
		if User.create(params.require(:user).permit(:name, :username, :password)).valid?
			redirect_to action: 'index'
			flash[:notice] = 'successfully created user!'
		else
			render action: 'new'
		end
		# User.create(params.require(:user).permit(:name, :username, :password))
		# redirect_to users_path
	end

end

# def create
#     if User.create(user_params)
#       redirect_to action: 'index'
#       flash[:notice] = "successfully created user!"
#     else
#       render action: 'new'
#     end
#   end