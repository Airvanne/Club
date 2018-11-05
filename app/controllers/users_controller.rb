class UsersController < ApplicationController

    def new
      @user = User.new
    end

    def create
        @user = User.new(user_params)    # Not the final implementation!
      if @user.save
        log_in @user
        flash[:success] = "Bienvenue dans la Sample App!"
        redirect_to @user
      else
        render 'new'
      end
      puts params
    end

    def show
      if logged_in?
        @user = User.find(params[:id])
      else
        redirect_to login_path
      end
    end

    def index
      if logged_in?
      else
      redirect_to login_path
      end
    end

    def edit

    end

    def update

    end

    def destroy

    end

    private

      def user_params
        params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
      end

end
