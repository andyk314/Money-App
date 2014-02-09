class AuthsController < ApplicationController


	# Show a login form
	def new
		if current_user
			redirect_to portfolios_path
		else
			@user = User.new
		end
	end

	# Log them in!
	def create
		user = User.find_by(username: params[:user][:username])
		if user.authenticated?(params[:user][:password])
			session[:user_id] = user.id
			redirect_to portfolios_path
		else
			redirect_to users_path
		end
	end

	# Log out
	def destroy
		session[:user_id] = nil
		redirect_to new_auth_path
	end


end