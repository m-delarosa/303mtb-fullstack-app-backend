class UsersController < ApplicationController
    before_action :authenticate, only: [:index, :show, :update, :destroy]
    
    def index
        @users = User.all
        render json: @users, include: [:user_trails]
    end
        
    def show
        @user = User.find(params[:id])
        render json: @user
    end
        
    def create
        @user = User.new(user_params)
        if @user.save
        render json: {message: "Your account was successfully created!", user: @user}
        else
        render json: @user.errors.messages
        end
    end
        
    def update
        @user = User.find(params[:id])
        if @user.update(user_params)
        render json: @user
        else
        render json: @user.errors.messages
        end
    end
        
    def destroy
        @user = User.find(params[:id])
        @user.destroy
        render json: {message: "User account sucessfully deleted"} 
    end
        
    private
    
    def user_params
        params.require(:user).permit([:name, :username, :email, :password])
    end
end
