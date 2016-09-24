class UsersController < ApplicationController
	before_action :authenticate_user_from_token!
  before_action :authenticate_user!
	
	def index
		@users = User.all

		respond_with @users, status: 200
	end
end