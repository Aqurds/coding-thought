class LikesController < ApplicationController
  # This part of the code finds the user and post based on the parameters passed in the request (user_id and post_id).
  # It then initializes a new Like instance associating it with the found user and post.
  def create
    @user = User.find(params[:user_id])
    @post = Post.find(params[:post_id])
    @like = Like.new(user: @user, post: @post)

    # attempts to save the new like. If the save is successful,
    # it sets a success notice in the flash message. If the save fails,
    # it sets an alert in the flash message.
    if @like.save
      flash[:notice] = 'Like added successfully to the post!'
    else
      flash[:alert] = 'Like was not added! Please try again'
    end

    # Finally, regardless of whether the like was successfully saved or not,
    # the user is redirected to the user_post_path
    redirect_to user_post_path(@user, @post)
  end
end
