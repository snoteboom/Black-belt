class LikesController < ApplicationController
  def create
  	@like = Post.find(params[:post_id]).likes.build(like_params)
  	@like.user = current_user
  	if @like.save
  		flash[:notice] = 'liked!'
  		redirect_to users_path
  	else
  		render :text => "cue explosions and death!"
  	end
  end

    private
  	def like_params
  		params.require(:like).permit(:like)
  	end
end
