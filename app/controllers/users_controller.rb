class UsersController < ApplicationController
  def new #form to make new user
    @user = User.new
  end

  def create #restful route to make new user!
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:notice] = 'New user created!'
      redirect_to signin_path 
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to new_user_path
    end
  end
  def show
    @user = User.find(params[:id])
  end

  #Since we're building the wall, I want to make the index method the wall page
  def index
    @post = Post.new
    @posts = Post.all.order(:created_at => :desc)
    @like = Like.all
  end
  #define strong parameters!
  private
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
    end
end