class CommentsController < ApplicationController
  # The new action is responsible for rendering the form to create a new comment.
  # It retrieves the corresponding post based on the post_id parameter,
  # creates a new comment instance, and sets @user to the @current_user.
  # It's assumed that @current_user is set elsewhere in the application, likely through user authenticatio
  def new
    @post = Post.find(params[:post_id])
    @comment = Comment.new
    @user = @current_user
  end

  # The create action is responsible for handling the form submission to create a new comment.
  # It first finds the user based on the user_id parameter,
  # then finds the corresponding post based on the post_id parameter.
  # It then initializes a new comment associated with the post and the user,
  # using the comment_params method to permit only the necessary parameters (in this case, just :text).
  def create
    @user = User.find(params[:user_id]) # Get the user from params
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params.merge(user: @user))

    if @comment.save
      redirect_to user_post_path(@user, @post), notice: 'Comment created successfully!'
    else
      render :new
    end
  end

  private

  # The comment_params method is a private method that uses Rails' strong parameters
  # to whitelist and permit only the :text parameter from the submitted form data.
  # This helps protect against mass assignment vulnerabilities.
  def comment_params
    params.require(:comment).permit(:text)
  end
end
