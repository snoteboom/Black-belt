class PostsController < ApplicationController
  def create
  	# use and build are similar, make sure to know both
  	@post = current_user.posts.build(post_params)
  	
  	if @post.save
  		flash[:notice] = 'added new post!!'
  		#back to the index method of the users controller
  		redirect_to users_path
  	else
  		render :text => 'what happened?'
  	end


  end

  def destroy

  	 @post = Post.find(params[:id])
    if current_user == @post.user
      if @post.delete
        flash[:message] = "Post DELETED succesfully"
        redirect_to users_path
      else
        flash[:message] = "Post CANNOT be deleted"
        redirect_to users_path
      end
    else
      flash[:notice] = "You can only delete your own posts!"
       redirect_to users_path
    end
  end

  private
  	# STRONG PARMAS
  	def post_params
  		params.require(:post).permit(:text)
  	end
end
