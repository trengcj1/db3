 before_filter :set_headers
 class UsersController < ApplicationController
  # GET /users
  # GET /users.json
  def index
    @users = User.all

    render json: @users
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    render json: @user
  end
  
  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params(params[:user]))

    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end
  
  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    @user = User.find(params[:id])

    if @user.update(params[:user])
      head :no_content
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end
  
  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    head :no_content
  end
  
  def splatts
  @user = User.find(params[:id])
  render json: @user.splatts
  end
  
  # GET /users/follows/1
  # GET /users/follows/1.json
  def show_follows
  @user = User.find(params[:id])
  
  render json: @user.follows
  end

  # GET /users/followers/1
  # GET /users/followers/1.json
  def show_followers
  @user = User.find(params[:id])
  #gets followers of a given user
  render json: @user.followed_by
  end
  
  #if user wants to follow someone
  def add_follows
	  @follower = User.find(params[:id])
	  @followed = User.find(params[:follows_id])
	  
	  if @follower.follows << @followed
		  head :no_content
		  else
		  render json: @follower.errors, status: :unprocessable_entity
	  end
  
  end
  
  #delete user
  def delete_follows
	  @follower = User.find(params[:id])
	  @followed = User.find(params[:follows_id])
	  
	  if @follower.follows.destroy(@followed)
	  head :no_content
	  else
	  render json: @follower.errors, status: :unprocessable_entity
	  end
  end

  def splatts_feed
	@feed = Splatt.find_by_sql("SELECT * FROM splatts JOIN follows ON follows.followed_id = splatts.user_id
							WHERE follows.follower_id = #{params[:id]} ORDER BY created_at DESC")
	render json: @feed
  end
  
  private
  def user_params(params)
  params.permit(:email, :password, :name, :blurb)
  end
  
  #method applies the set_headers method before performing other methods
  def set_headers
  headers['Access-Control-Allow-Origin'] = '*'
  end
  
end
