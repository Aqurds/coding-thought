class PostsController < ApplicationController
  def index
    # This action retrieves all posts belonging to a specific user (specified by params[:user_id])
    # and assigns them to the @posts instance variable.
    # It's commonly used for displaying a list of posts for a particular user on the index page.
    @posts = Post.includes(:comments).where(author_id: params[:user_id])
    @users = User.includes(:comments).where(id: params[:user_id])
  end

  def show
    # This action finds a single post based on the id parameter in the request
    # and assigns it to the @post instance variable.
    # It's used for displaying the details of a specific post on its own page.
    @post = Post.find(params[:id])
  end

  def new
    # This action is responsible for preparing the form to create a new post.
    # It finds the user (specified by params[:user_id]) and assigns it to the @user instance variable.
    # It initializes a new empty post object and assigns it to the @post instance variable.
    @user = User.find(params[:user_id])
    @post = Post.new
  end

  def create
    # This action is triggered when the form for creating a new post is submitted.
    # It sets the current user (assuming the set_current_user method is defined elsewhere).
    # It builds a new post associated with the current user using the parameters
    # from the form (permitted by post_params).
    # It sets the initial values for comments_counter and likes_counter
    # (assuming these are counters for comments and likes on the post).
    # If the post is successfully saved, it redirects to the show page for the newly created post with a success notice.
    # If the save fails, it renders the new template again, showing validation errors.

    @post = current_user.posts.build(post_params)
    @post.comments_counter = 0
    @post.likes_counter = 0

    if @post.save
      redirect_to user_post_path(current_user.id, @post.id), notice: 'Post was successfully Created'
    else
      render :new
    end
  end

  private

  def post_params
    # This is a private method that uses strong parameters to whitelist
    # and permit only the :title and :text parameters for creating a post.
    # It helps protect against mass assignment vulnerabilities.
    params.require(:post).permit(:title, :text)
  end
end
